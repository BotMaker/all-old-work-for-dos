/* Euphoria 2.4 
   C include file for Euphoria programs 
   that have been translated to C */

#undef _segment
#undef _self
#undef _dos_ds

#define NOVALUE      ((long)0xbfffffffL)
#define IS_ATOM_INT(ob)       (((long)(ob)) > NOVALUE)
#define IS_ATOM_DBL(ob)         (((object)(ob)) >= (long)0xA0000000)
#define IS_ATOM(ob)             (((long)(ob)) >= (long)0xA0000000)
#define IS_SEQUENCE(ob)         (((long)(ob))  < (long)0xA0000000)
#define IS_DBL_OR_SEQUENCE(ob)  (((long)(ob)) < NOVALUE)
#define HIGH_BITS    ((long)0xC0000000L)

#undef MININT
#undef MAXINT
#define MININT     (long)0xC0000000
#define MAXINT     (long)0x3FFFFFFF
#define MAXINT_VAL MAXINT
#define MAXINT_DBL ((double)MAXINT_VAL)
#define INT15      (long)0x00003FFFL

#define LOW_MEMORY_MAX ((unsigned)0x0010FFEF)

typedef int object;
typedef int *object_ptr;

struct s1 {
    object_ptr base;
    long length;
    long ref;
    long postfill;
};

struct d {
    double dbl;
    long ref;
};

struct routine_list {
    char *name;
    int (*addr)();
    int num_args;
    int seq_num;
    int file_num;
};

struct ns_list {
    char *name;
    int ns_num;
    int seq_num;
    int file_num;
};

typedef struct d  *d_ptr;
typedef struct s1 *s1_ptr;

#define MAKE_DBL(x) ( (int) (((unsigned)(x) >> 3) + (long)0xA0000000) )
#define DBL_PTR(ob) ( (d_ptr)  (((unsigned)(ob)) << 3) )
#define MAKE_SEQ(x) ( (int) (((unsigned)(x) >> 3) + (long)0x80000000) )
#define SEQ_PTR(ob) ( (s1_ptr) (((unsigned)(ob)) << 3) ) 

#define RefDS(a) ++(DBL_PTR(a)->ref)    
#define RefDSn(a,n) (DBL_PTR(a)->ref += n)    
#define Ref(a) if (IS_DBL_OR_SEQUENCE(a)) { RefDS(a); }
#define Refn(a,n) if (IS_DBL_OR_SEQUENCE(a)) { RefDSn(a,n); }

#define DeRefDS(a) if (--(DBL_PTR(a)->ref) == 0 ) { de_reference((s1_ptr)(a)); }
#define DeRefDSi(a) if (--(DBL_PTR(a)->ref) == 0 ) { de_reference_i((s1_ptr)(a)); }

#define DeRef(a) if (IS_DBL_OR_SEQUENCE(a)) { DeRefDS(a); }
#define DeRefi(a) if (IS_DBL_OR_SEQUENCE(a)) { DeRefDSi(a); }

#define UNIQUE(seq) (((s1_ptr)(seq))->ref == 1)

#define EF_READ 1

#define LESS       0 
#define GREATEREQ  1
#define EQUALS     2
#define NOTEQ      3
#define LESSEQ     4
#define GREATER    5
#define NOT        6
#define AND        7  
#define OR         8
#define MINUS      9
#define PLUS      10
#define UMINUS    11
#define MULTIPLY  12
#define DIVIDE    13
#define OR_BITS   23  
#define XOR_BITS  26 
#define SQRT      40
#define NOT_BITS  50 
#define AND_BITS  55
#define RAND      61
#define FLOOR_DIV 62
#define REMAINDER 70 
#define POWER     71 
#define ARCTAN    72  
#define LOG       73
#define SIN       79
#define COS       80
#define TAN       81
#define FLOOR     82
#define XOR      153

int wingetch();
int call_c();
int Command_Line();
void show_console();
int Dpower();
int Dand_bits();
int Dand();
int Dremainder();
void Cleanup();
void init_literal();
char **make_arg_cv();
int NewDouble(double);
void DeRef5(int, int, int, int, int);
void de_reference(s1_ptr);
void de_reference_i(s1_ptr);
double current_time(void);
double floor(double);
double fabs(double);
int binary_op_a(int, int, int);
int binary_op(int, int, int);
void *which_file(int, int);
int unary_op(int, int);
int NewS1(int);
int compare(int, int);
unsigned long get_pos_int(char *, int);
int memory_set(int, int, int);
int memory_copy(int, int, int);
int getc(void *);
int EOpen(int, int);
void EClose(int);
int EPrintf(int, int, int);
void EPuts(int, int);
void Concat(int *, int, s1_ptr);
void Concat_N(int *, int **, int);
void Append(int *, int, int);
void Prepend(int *, int, int);
int EGetenv(s1_ptr);
void RHS_Slice(s1_ptr, int, int);
int find(int, int);
int e_match(int, int);
void ctrace(char *);
int e_floor(int);
int DoubleToInt(int);
int machine(int, int);
int Repeat(int, int);
void RepeatElem(int, int, int);
int SequenceCopy(s1_ptr);
int power(int, int);
int EGets(int);
int Pixel(int, int);
int Get_Pixel(int);
void shift_args(int, char**);
int NewString(char *);
char *malloc(int);
void eu_startup();
void exit(int);
int CRoutineId(int, int, int);
int e_sqrt(int);
int e_arctan(int);
void AssignSlice(int, int, int);
void StdPrint(int, int, int);
void ClearScreen();
void Position(int, int);
int CommandLine(void);
void system_call(int, int);
void RTFatal(char *);

