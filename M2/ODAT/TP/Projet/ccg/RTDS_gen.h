/* Project: /home/Romain/Documents/Cours/M2/ODAT/TP/Projet/Atelier.rdp */
/* Diagram: /home/Romain/Documents/Cours/M2/ODAT/TP/Projet/Atelier.rdd */

#include "RTDS_MACRO.h"
#include "RTDS_CommonTypes.h"

#ifdef __cplusplus
extern "C" {
#endif

/* DEFINES FOR STATES */
#define RTDS_state_WAIT_DROP_ORDER 1
#define RTDS_state_REMOVING 2
#define RTDS_state_WAIT_PICK_DONE 3
#define RTDS_state_PLACING 4
#define RTDS_state_WAIT_PLACE_DONE 5
#define RTDS_state_WAIT_DROP_DONE 6
#define RTDS_state_FAILURE 7
#define RTDS_state_IDLE 8
#define RTDS_state_MACHINING 9
#define RTDS_state_WAIT_REMOVE_DONE 10
#define RTDS_state_READY 11
#define RTDS_state_WAIT_MACH_END 12
#define RTDS_state_DROPPING 13

/* DEFINES FOR SIGNALS AND TIMERS */
char * RTDS_get_message_name(char * name, int id);
#define RTDS_message_T_MACH 1
#define RTDS_message_Sys_Failure 2
#define RTDS_message_Cmd_StopAll 3
#define RTDS_message_Cmd_DropToConv 4
#define RTDS_message_Cmd_Remove 5
#define RTDS_message_Ack_PlaceDone 6
#define RTDS_message_Sensor_RemoveDone 7
#define RTDS_message_T_PREP 8
#define RTDS_message_Cmd_Place 9
#define RTDS_message_Sensor_MachinePickDone 10
#define RTDS_message_T_PICK 11
#define RTDS_message_Ack_Picked 12
#define RTDS_message_Sensor_MachineDropDone 13
#define RTDS_message_Sensor_PlaceDone 14
#define RTDS_message_NewPiece 15
#define RTDS_message_T_REMOVE 16
#define RTDS_message_Rpt_EndMachining 17
#define RTDS_message_Cmd_Prepare 18
#define RTDS_message_Ack_Dropped 19
#define RTDS_message_Ack_RemoveDone 20
#define RTDS_message_T_FEED 21

/* DEFINES FOR SEMAPHORES */

/* DEFINES FOR PROCESSES */
#define RTDS_process_Supervisor 1
#define RTDS_process_RobotRemove 2
#define RTDS_process_Machine1 3
#define RTDS_process_RobotFeed 4
#define RTDS_process_Machine2 5

/* PROCESS PROTOTYPES */
RTDS_TASK_ENTRY_POINT_PROTO(Supervisor);
RTDS_TASK_ENTRY_POINT_PROTO(RobotRemove);
RTDS_TASK_ENTRY_POINT_PROTO(Machine1);
RTDS_TASK_ENTRY_POINT_PROTO(RobotFeed);
RTDS_TASK_ENTRY_POINT_PROTO(Machine2);

#ifdef __cplusplus
}
#endif

