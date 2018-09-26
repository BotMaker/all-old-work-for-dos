-- sched.e
-- Task Scheduler

-- This is perhaps the most interesting source file since it shows a
-- simple technique of task scheduling that could be used in any action 
-- game or simulation program. 

-- We have implemented a form of cooperative multitasking to manage over 10 
-- independent tasks. There is a task that moves the Euphoria, another task 
-- that checks the keyboard for input, a task that makes enemy ships fire, 
-- another that counts down the damage report, etc. The sequence "tcb" records
-- the time at which each task wants to be activated next. When the time comes 
-- to run a given task, next_task() will run it. 

-- For example, the task that moves the Euphoria will ask to be activated 
-- again in 20 seconds if the Euphoria is moving at warp 1, or much less at 
-- higher warps. The keyboard checking task is activated very frequently, but 
-- usually returns quickly (no key pressed). 

-- Some tasks require very precise activation times to make things look 
-- realistic, e.g. Euphoria moving at warp 5. Others do not, for example the 
-- BASIC TRUCE/HOSTILE/CLOAKING task which is activated after a lengthy and 
-- random amount of time. In recognition of this we have the "eat" (early 
-- activation tolerance) variable. After choosing the next task to run, and 
-- before entering into a delay loop to wait for the activation time to come,
-- next_task() will check T_EARLY to see if it can activate the task a bit
-- sooner. This will get this task out of the way and reduce the chance of a 
-- timing conflict with the next task.

-- It's possible to have multiple logical tasks all running the same routine, 
-- but with different private data (parameters and private variables). For 
-- instance, there could be several torpedo tasks active at the same time. 
-- Each torpedo task has it's own set of private variables. It returns a 
-- sequence to next_task() containing the arguments that it wants to be 
-- called with the next time it is activated. This sequence is saved in the 
-- tcb for that task and allows it to preserve its own state variables 
-- between activations.

sequence tcb -- task control block
tcb = {}

global integer t_keyb,    -- keyboard input
	       t_emove,   -- Euphoria move
	       t_life,    -- life support energy consumption
	       t_dead,    -- dead body cleanup
	       t_bstat,   -- BASIC status change
	       t_fire,    -- enemy firing
	       t_move,    -- enemy moving 
	       t_message, -- display messages
	       t_damage_report,  -- damage count-down
	       t_enter,   -- enemy ships enter quadrant
	       t_sound_effect,   -- sound effects
	       t_gquad    -- refresh current quadrant on scan
	       
global constant INACTIVE = -1 
constant HUGE_TIME = 1e30

constant T_ROUTINE     = 1,  -- routine id
	 T_ACTIVATE    = 2,  -- next activation time
	 T_NORMAL_WAIT = 3,  -- normal time between activations
	 T_EARLY       = 4,  -- early activation tolerance
	 T_ARGS        = 5   -- private data passed as arguments to this task

global type task(integer x)
-- is x a valid task number?
    return x >= 1 and x <= length(tcb)
end type

global task current_task -- current task executing

type valid_routine_id(integer id)
    return id >= 0 and id <= 1000
end type

global function create_task(valid_routine_id proc_id)
-- create a new independent task
    sequence entry
    
    entry = {proc_id, HUGE_TIME, HUGE_TIME, 0, {}}
    for i = 1 to length(tcb) do
	if tcb[i][T_ROUTINE] = -1 then
	    -- found an empty spot, insert it here
	    tcb[i] = entry
	    return i
	end if
    end for
    -- grow the tcb
    tcb = append(tcb, entry)
    return length(tcb)
end function

global procedure delete_task(task t)
-- delete task t
    tcb[t][T_ROUTINE] = -1
    tcb[t][T_ACTIVATE] = HUGE_TIME
    tcb[t][T_NORMAL_WAIT] = HUGE_TIME
end procedure

global procedure purge_tasks(valid_routine_id r)
    for i = 1 to length(tcb) do
	if tcb[i][T_ROUTINE] = r then
	    delete_task(i)
	end if
    end for
end procedure

global procedure schedule(task t, atom next, 
				  atom again, 
				  atom early,
				  object args)
-- schedule a task to start in <next> seconds from now, 
-- repeat every <again> seconds, 
-- with early activation tolerance of <early>
-- and private state information contained in <args>

    -- activate the task in wait seconds *from now*
    if next = INACTIVE then
	-- deactivate the task
	tcb[t][T_ACTIVATE] = HUGE_TIME
    else
	tcb[t][T_ACTIVATE] = time() + next
    end if
    
    if again = INACTIVE then
	-- no more after next activation
	tcb[t][T_NORMAL_WAIT] = HUGE_TIME
    else
	tcb[t][T_NORMAL_WAIT] = again
    end if
    
    tcb[t][T_EARLY] = early
    tcb[t][T_ARGS] = args
end procedure

integer late, not_late
not_late = 0
late = 0

global procedure next_task()
-- choose the next task and execute it

    positive_atom min_time, base_time, start_time
    task min_task
    
    -- reschedule the current task
    base_time = time()
    if base_time < tcb[current_task][T_ACTIVATE] then
	base_time = tcb[current_task][T_ACTIVATE]
    end if
    tcb[current_task][T_ACTIVATE] = base_time + tcb[current_task][T_NORMAL_WAIT]
    
    -- find the task with minimum activation time
    min_task = 1
    min_time = tcb[1][T_ACTIVATE]
    for i = 2 to length(tcb) do
	if tcb[i][T_ACTIVATE] < min_time then
	    min_task = i
	    min_time = tcb[i][T_ACTIVATE]
	end if
    end for

    -- subtract it's early-activation tolerance
    start_time = tcb[min_task][T_ACTIVATE] - tcb[min_task][T_EARLY]

    -- wait until it is time to activate it
    while time() < start_time do
    end while

    current_task = min_task
    tcb[current_task][T_ARGS] = call_func(tcb[current_task][T_ROUTINE], 
					  tcb[current_task][T_ARGS])
end procedure

global procedure shift_task_times(atom amount)
-- adjust all task times (when user delays the game)
    for i = 1 to length(tcb) do
	tcb[i][T_ACTIVATE] += amount
    end for
end procedure


-- below we have some code that lets us perform short accurate time delays
-- with better resolution than the usual 18.2 ticks per second under MS-DOS
constant sample_interval = 1.0
atom sample_count

type reasonable_delay(atom x)
    return x >= 0 and x < 30
end type

global procedure init_delay()
-- since time() does not have fine enough
-- resolution for small delays, we see how many for-loop iterations
-- we can complete over a small sample period

    atom t

    t = time() + sample_interval
    for i = 1 to 999999999 do
	if time() < t then
	else
	    sample_count = i
	    exit
	end if
    end for
end procedure

global procedure delay(reasonable_delay t)
-- delay for t seconds
    atom stop
    integer iter
    if t > sample_interval then
	-- time() should be precise enough
	stop = time() + t
	while time() < stop do
	end while
    else
	-- loop a certain number of times
	stop = time() + sample_interval
	iter = floor(t / sample_interval * sample_count)
	for i = 1 to iter do
	    if time() < stop then
	    else
	    end if
	end for
    end if
end procedure

