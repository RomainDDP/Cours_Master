/* ***************************************************************** */
/* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Include.c begins         */
/* PragmaDev RTDS posix integration                                  */
#include <stdlib.h>
#include <stdio.h>
/* Include unistd when using a unix based system or cygwin */
#include <unistd.h>

/* POSIX includes */
#include <semaphore.h>
#include <pthread.h>
#include <signal.h>
#include <time.h>

#include "RTDS_Error.h"
#include "RTDS_MACRO.h"
#include "RTDS_OS.h"

#if defined( RTDS_FORMAT_TRACE )
#include "RTDS_FormatTrace.h"
#endif

/* $(RTDS_HOME)/share/ccg/posic/bricks/RTDS_Include.c ends           */
/* ***************************************************************** */
#include "RTDS_gen.h"
#include "Atelier.h"


/* ***************************************************************** */
/* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Startup_begin.c begins */
/* PragmaDev RTDS posix integration */

#if defined( RTDS_CMD_INTERPRETER )
#include "RTDS_CmdInterpreter.h"
#endif

#ifdef RTDS_SOCKET_PORT
int globalClientSocketId = 0;
#endif

#ifdef __cplusplus
extern "C" 
  {
  void RTDS_StopProgram( void );
  }
#endif

/* Pointers to global list of information on processes and semaphores */
RTDS_GlobalProcessInfo *RTDS_globalProcessInfo = NULL;
RTDS_GlobalSemaphoreInfo *RTDS_globalSemaphoreInfo = NULL;

RTDS_COVERAGE_DECL;
RTDS_SYS_TIME_DECL;
RTDS_START_SYNCHRO_DECL;
RTDS_CRITICAL_SECTION_DECL;
RTDS_SOCKET_ACCESS_DECL;
RTDS_CRITICAL_TRACE_SECTION_DECL;
RTDS_DTRACE_ACKNOWLEDGE_DECL;

void RTDS_Start( void )
  {
  RTDS_GlobalProcessInfo *RTDS_currentContext;

  RTDS_SYS_TIME_INIT;
  RTDS_COVERAGE_INIT;

  #ifdef RTDS_SIMULATOR
  RTDS_globalTraceEntry.event = RTDS_systemError;
  RTDS_globalTraceEntry.currentContext = NULL;
  #endif

  #if defined( RTDS_BACK_TRACE_MAX_EVENT_NUM ) && defined( RTDS_SIMULATOR )
  RTDS_TraceInit();
  #endif

  #if defined(RTDS_SIMULATOR) || defined(RTDS_MSC_TRACER)
  /* Set up the message unique id pool */
  RTDS_globalMessageUniqueIdPool = RTDS_MALLOC( RTDS_MESSAGE_UNIQUE_ID_POOL_SIZE );
    {
    int RTDS_i;
    unsigned char *RTDS_index;

    RTDS_index = ( unsigned char * )RTDS_globalMessageUniqueIdPool;
    for( RTDS_i = 0 ; RTDS_i < RTDS_MESSAGE_UNIQUE_ID_POOL_SIZE ; RTDS_i++ )
      {
      *RTDS_index = 0x00;
      RTDS_index++;
      }
    }
  #endif

  /* Set up the process context needed to create tasks */
  RTDS_currentContext = ( RTDS_GlobalProcessInfo * )RTDS_MALLOC( sizeof( RTDS_GlobalProcessInfo ) );
  if ( RTDS_currentContext == NULL )
    {
    RTDS_SYSTEM_ERROR( RTDS_ERROR_STARTUP_CONTEXT_MALLOC );
    }
  RTDS_currentContext->sdlProcessNumber = 0;
  RTDS_currentContext->myRtosTaskId = (RTDS_RtosTaskId)0;
  RTDS_currentContext->mySdlInstanceId = (RTDS_SdlInstanceId *)NULL;
  RTDS_currentContext->sdlState = 0;
  RTDS_currentContext->next = NULL;
  RTDS_currentContext->offspringSdlInstanceId = (RTDS_SdlInstanceId *)NULL;
  RTDS_currentContext->offspringSdlInstanceId = (RTDS_SdlInstanceId *)NULL;
  RTDS_currentContext->currentMessage = NULL;
  RTDS_currentContext->timerList = NULL;

  /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Startup_begin.c ends */
  /* *************************************************************** */


  /* SEMAPHORE CREATIONS */

  /* PROCESS CREATIONS */
  RTDS_STARTUP_PROCESS_CREATE("Machine1", RTDS_process_Machine1, Machine1, RTDS_DEFAULT_PROCESS_PRIORITY);
  RTDS_STARTUP_PROCESS_CREATE("RobotRemove", RTDS_process_RobotRemove, RobotRemove, RTDS_DEFAULT_PROCESS_PRIORITY);
  RTDS_STARTUP_PROCESS_CREATE("Supervisor", RTDS_process_Supervisor, Supervisor, RTDS_DEFAULT_PROCESS_PRIORITY);
  RTDS_STARTUP_PROCESS_CREATE("RobotFeed", RTDS_process_RobotFeed, RobotFeed, RTDS_DEFAULT_PROCESS_PRIORITY);
  RTDS_STARTUP_PROCESS_CREATE("Machine2", RTDS_process_Machine2, Machine2, RTDS_DEFAULT_PROCESS_PRIORITY);
  /* *************************************************************** */
  /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Startup_end.c begins */
  /* PragmaDev RTDS posix integration */

  RTDS_SIMULATOR_TRACE( RTDS_initDone , NULL , (long int) NULL , RTDS_currentContext );

  /* Let all the created process run now */
  RTDS_START_SYNCHRO_GO;

  /* To avoid the master creator thread to exit */

  #ifndef RTDS_MAIN
  while ( 1 )
    {
    sleep( 3600 );
    }
  #endif
  }

/* **************************************************************** *
*    RTDS_StopProgram
* **************************************************************** *
*    Function for stopping program using breakpoint and
*    command interpreter Client
* **************************************************************** */
void RTDS_StopProgram( void )
  {
  }

/* **************************************************************** *
*    main
* **************************************************************** *
*    Main entry
* **************************************************************** */
#ifndef RTDS_MAIN
int main( void )
#else
int RTDS_MAIN( void )
#endif
  {
  int socketEnable = 0;

  #ifdef RTDS_CMD_INTERPRETER
  enum RTDS_CmdType commandId;
  RTDS_UnionCommandParam * pCommandParam;
  /* Variable for sending SDL message*/
  RTDS_CmdSendMsg2ProcNumber *paramSendMsg2pNumber = NULL;
  RTDS_CmdSendMsg2ProcId * paramSendMsg2pId = NULL;
  RTDS_SdlInstanceId * receiver;
  RTDS_SdlInstanceId * sender;
  RTDS_GlobalProcessInfo * processInfoSender;
  RTDS_GlobalProcessInfo *processInfoReceiver;
  /* Variable for forcing timer */
  RTDS_CmdForceTimer * paramForceTimer = NULL;
  #ifdef RTDS_FORMAT_TRACE
  /* Variable for configuring trace */
  RTDS_CmdTraceConfig *paramTraceConf = NULL;
  #endif
  #endif

  #if defined ( RTDS_SOCKET_PORT ) && ( defined ( RTDS_SIMULATOR ) || defined ( RTDS_MSC_TRACER ) )
  char *currentData; /* ptr on data to read from socket */
  int currentSize; /* Data size to read from socket */

  RTDS_SOCKET_ID_TYPE clientSocketId = 0;
  RTDS_RtosTaskId commandInterThreadId;
  #endif

  RTDS_SOCKET_ACCESS_INIT;
  RTDS_CRITICAL_SECTION_INIT;
  RTDS_START_SYNCHRO_INIT;
  RTDS_CRITICAL_TRACE_SECTION_INIT;

  #if defined ( RTDS_SOCKET_PORT ) && ( defined ( RTDS_SIMULATOR ) || defined ( RTDS_MSC_TRACER ) )
  clientSocketId = RTDS_InitSocket( GET_HOSTNAME_STRING( RTDS_SOCKET_IP_ADDRESS ) , RTDS_SOCKET_PORT );
  if( !( clientSocketId == RTDS_ERROR || clientSocketId == 0 ) )
    {
    socketEnable = 1;
    /* global variable for sending data */
    globalClientSocketId = clientSocketId;
    }
  else
    {
    printf("Error. Executable could not connect to PragmaDev debugger or tracer.\n");
    exit(RTDS_ERROR_SOCKET_CONNECTION);
    }
  #endif

  #if defined( RTDS_SIMULATOR ) && defined( RTDS_CMD_INTERPRETER ) && defined( RTDS_SOCKET_PORT )
  /* Init acknowledge semaphore */
  RTDS_DTRACE_ACKNOWLEDGE_INIT;

  /* RTDS_Start is started in a  thread*/
  commandInterThreadId = RTDS_TaskCreate( RTDS_DEFAULT_TCP_CLIENT_PRIORITY , ( void *( * )( void * ) )RTDS_Start , ( void* )NULL );
  if ( socketEnable == 1 )
    {
    while( RTDS_ReadSocket( clientSocketId , &currentData , &currentSize , RTDS_CMD_DELIMITERCHAR, RTDS_ESCAPECHAR ) != -1)
      {
      if ( RTDS_InterpretCommand( currentData , &commandId , &pCommandParam ) != RTDS_ERROR )
        {
        /* Process command */
        switch( commandId )
          {
          case ACK_CMDID:
          RTDS_DTRACE_ACKNOWLEDGE_RECEIVED;
          break;

          case STOP_CMDID:
          RTDS_StopProgram();
          break;

          case MSG2PROCID:
          /* pCommandParam is a valid RTDS_CmdSendMsg2ProcId struct */
          paramSendMsg2pId = ( RTDS_CmdSendMsg2ProcId * )pCommandParam;
          /* Get Receiver QueueId */
          processInfoReceiver = RTDS_GetProcessInfoFromProcessId( paramSendMsg2pId->receiver );
          /* Get Sender QueueId*/
          processInfoSender = RTDS_GetProcessInfoFromProcessId( paramSendMsg2pId->sender );


          /* Ignore if receiver is not known */
          if (processInfoReceiver == NULL)
            {
            break;
            }
          if (processInfoSender == NULL)
          sender = NULL;
          else
          sender = processInfoSender->mySdlInstanceId;
          receiver = processInfoReceiver->mySdlInstanceId;

          RTDS_SimulatorMsgQueueSend(
          paramSendMsg2pId->messageNumber ,
          paramSendMsg2pId->dataLength ,
          paramSendMsg2pId->pData ,
          receiver ,
          sender ,
          processInfoSender );
          break;

          case MSG2PROCNUM:
          /* pCommandParam is a valid RTDS_CmdSendMsg2ProcNumber struct */
          paramSendMsg2pNumber = ( RTDS_CmdSendMsg2ProcNumber * )pCommandParam;
          /* Get Sender QueueId*/
          processInfoSender = RTDS_GetProcessInfoFromProcessNum( paramSendMsg2pNumber->sender );

          RTDS_SimulatorMsgQueueSend(
          paramSendMsg2pNumber->messageNumber ,
          paramSendMsg2pNumber->dataLength ,
          paramSendMsg2pNumber->pData ,
          RTDS_GetProcessQueueId( paramSendMsg2pNumber->receiver ) ,
          RTDS_GetProcessQueueId( paramSendMsg2pNumber->sender ) ,
          processInfoSender );
          break;

          case TIMER_CMDID:
          /* pCommandParam is a valid RTDS_CmdForceTimer struct */
          paramForceTimer = ( RTDS_CmdForceTimer * )pCommandParam;
          RTDS_ForceTimer( paramForceTimer->pId , paramForceTimer->timerNum );
          break;

          case SYSCLOCK_CMDID:
          RTDS_SetSystemTime( ( long )pCommandParam );
          break;

          case TRACE_CMDID:
          #ifdef RTDS_FORMAT_TRACE
          paramTraceConf = ( RTDS_CmdTraceConfig * )pCommandParam;
          RTDS_ConfigureTrace( paramTraceConf );
          #endif
          break;
          case MSG2PROCNAME :
          default :
          break;
          }
        }
      RTDS_FREE( currentData );
      }
    }
  #else
  /* Call Start function (that will run SDL Task and run program) */
  RTDS_Start();
  #endif

  #ifndef RTDS_MAIN
  if ( socketEnable == 0 )
    {
    /* To avoid the main thread to exit */
    while ( 1 )
      {
      sleep( 3600 );
      }
    }
  #endif

  return 0;
  }

/* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Startup_end.c ends */
/* ************************************************************* */

