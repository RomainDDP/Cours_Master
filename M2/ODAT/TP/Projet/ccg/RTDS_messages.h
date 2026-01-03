#ifndef _RTDS_MESSAGES_H_
#define _RTDS_MESSAGES_H_

#include "RTDS_CommonTypes.h"
#include "Atelier.h"

#ifdef __cplusplus
extern "C" {
#endif


/* DATA TYPES FOR MESSAGES */
#ifndef RTDS_Sensor_MachinePickDone_DATA_DEFINED
typedef struct RTDS_Sensor_MachinePickDone_data
{
	MachineId	param1;
} RTDS_Sensor_MachinePickDone_data;
#define RTDS_Sensor_MachinePickDone_DATA_DEFINED
#endif

#ifndef RTDS_Ack_Picked_DATA_DEFINED
typedef struct RTDS_Ack_Picked_data
{
	MachineId	param1;
} RTDS_Ack_Picked_data;
#define RTDS_Ack_Picked_DATA_DEFINED
#endif

#ifndef RTDS_Sensor_MachineDropDone_DATA_DEFINED
typedef struct RTDS_Sensor_MachineDropDone_data
{
	MachineId	param1;
} RTDS_Sensor_MachineDropDone_data;
#define RTDS_Sensor_MachineDropDone_DATA_DEFINED
#endif

#ifndef RTDS_Rpt_EndMachining_DATA_DEFINED
typedef struct RTDS_Rpt_EndMachining_data
{
	MachineId	param1;
} RTDS_Rpt_EndMachining_data;
#define RTDS_Rpt_EndMachining_DATA_DEFINED
#endif

#ifndef RTDS_Ack_Dropped_DATA_DEFINED
typedef struct RTDS_Ack_Dropped_data
{
	MachineId	param1;
} RTDS_Ack_Dropped_data;
#define RTDS_Ack_Dropped_DATA_DEFINED
#endif

#ifndef RTDS_Cmd_Place_DATA_DEFINED
typedef struct RTDS_Cmd_Place_data
{
	MachineId	param1;
} RTDS_Cmd_Place_data;
#define RTDS_Cmd_Place_DATA_DEFINED
#endif


/* MACRO FOR DECLARATIONS FOR MESSAGE SEND/RECEIVE */

#ifndef RTDS_MSG_DATA_DECL
#define RTDS_MSG_DATA_DECL unsigned char * RTDS_msgData;
#endif  /* RTDS_MSG_DATA_DECL defined */

%%%SEND-RECEIVE-MACROS%%%

#ifdef __cplusplus
}
#endif

#endif /* defined(_RTDS_MESSAGES_H_) */

