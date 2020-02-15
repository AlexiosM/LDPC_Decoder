/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_223(char*, char *);
extern void execute_224(char*, char *);
extern void execute_225(char*, char *);
extern void execute_40(char*, char *);
extern void execute_41(char*, char *);
extern void execute_222(char*, char *);
extern void execute_47(char*, char *);
extern void execute_44(char*, char *);
extern void execute_46(char*, char *);
extern void execute_79(char*, char *);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_82(char*, char *);
extern void execute_87(char*, char *);
extern void execute_86(char*, char *);
extern void execute_199(char*, char *);
extern void execute_200(char*, char *);
extern void execute_211(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_38(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_40(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_42(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_44(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_45(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_46(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_48(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_49(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_50(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_51(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_52(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_53(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_54(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_55(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_56(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_57(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_58(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_59(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_60(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[41] = {(funcp)execute_223, (funcp)execute_224, (funcp)execute_225, (funcp)execute_40, (funcp)execute_41, (funcp)execute_222, (funcp)execute_47, (funcp)execute_44, (funcp)execute_46, (funcp)execute_79, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_87, (funcp)execute_86, (funcp)execute_199, (funcp)execute_200, (funcp)execute_211, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_38, (funcp)transaction_40, (funcp)transaction_41, (funcp)transaction_42, (funcp)transaction_44, (funcp)transaction_45, (funcp)transaction_46, (funcp)transaction_48, (funcp)transaction_49, (funcp)transaction_50, (funcp)transaction_51, (funcp)transaction_52, (funcp)transaction_53, (funcp)transaction_54, (funcp)transaction_55, (funcp)transaction_56, (funcp)transaction_57, (funcp)transaction_58, (funcp)transaction_59, (funcp)transaction_60, (funcp)transaction_61};
const int NumRelocateId= 41;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.reloc",  (void **)funcTab, 41);
	iki_vhdl_file_variable_register(dp + 57480);
	iki_vhdl_file_variable_register(dp + 57536);
	iki_vhdl_file_variable_register(dp + 60312);
	iki_vhdl_file_variable_register(dp + 60368);
	iki_vhdl_file_variable_register(dp + 60424);
	iki_vhdl_file_variable_register(dp + 60480);
	iki_vhdl_file_variable_register(dp + 60536);
	iki_vhdl_file_variable_register(dp + 60592);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.reloc");

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/LDPC_decoder_6_4_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
