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
#include "Machine2.h"
#include "RTDS_messages.h"
#include "RTDS_gen.h"

#define RTDS_PROCESS_NUMBER RTDS_process_Machine2
#define RTDS_PROCESS_NAME Machine2

/*
** PROCESS Machine2:
** -----------------
*/

RTDS_TASK_ENTRY_POINT(Machine2)
  {
  short RTDS_transitionExecuted;
  int RTDS_savedSdlState = 0;

  MachineId myId = M2;
  MachineId mid = M1;
  RTDS_MSG_DATA_DECL

  void * RTDS_myLocals[2];
  void ** RTDS_localsStack[1];


  /* *************************************************************** */
  /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Process_begin.c begins */
  /* PragmaDev RTDS posix integration                                */

  int RTDS_sdlStatePrev = 0;
  RTDS_SdlInstanceId *RTDS_senderId = NULL;

  RTDS_currentContext->readSaveQueue = NULL;
  RTDS_currentContext->writeSaveQueue = NULL;

  /* To synchronize processes at startup time */
  RTDS_START_SYNCHRO_WAIT;

  /*    $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Process_begin.c ends  */
  /* *************************************************************** */

  #include "Machine2_tempVars.h"

  RTDS_myLocals[0] = (void*)&mid;
  RTDS_myLocals[1] = (void*)&myId;
  RTDS_localsStack[0] = RTDS_myLocals;


  /* Initial transition */
  RTDS_SDL_STATE_SET(RTDS_state_IDLE);

  /* ***************************************************************** */
  /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_loopStart.c begins  */
  /* PragmaDev RTDS posix integration */

  /* Event loop */
  for ( ; ; )
    {
    /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_loopStart.c ends */
    /* *************************************************************** */

    /* *************************************************************** */
    /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_middle.c begins   */
    /* PragmaDev RTDS posix integration */

    /* Check saved messages */
    if ( RTDS_currentContext->readSaveQueue != NULL )
      {
      RTDS_currentContext->currentMessage = RTDS_currentContext->readSaveQueue;
      RTDS_currentContext->readSaveQueue = RTDS_currentContext->readSaveQueue->next;
      }
    /* If no saved messages left, get message from process's message queue */
    else
      {
      RTDS_currentContext->currentMessage = ( RTDS_MessageHeader * )RTDS_MALLOC( sizeof( RTDS_MessageHeader ) );
      RTDS_MSG_QUEUE_READ( RTDS_currentContext->currentMessage );
      RTDS_currentContext->currentMessage->next = NULL;
      }

    /* Discard cancelled timers */
    if ( RTDS_currentContext->currentMessage->timerUniqueId != 0 )
      {
      RTDS_TIMER_CLEAN_UP(RTDS_currentContext);
      }

    /* Let's process the message ! */
    if ( RTDS_currentContext->currentMessage != NULL )
      {
      RTDS_SIMULATOR_TRACE( RTDS_messageReceived , RTDS_currentContext->currentMessage , SELF , RTDS_currentContext );
      RTDS_senderId = RTDS_currentContext->currentMessage->sender;
      RTDS_sdlStatePrev = RTDS_currentContext->sdlState;
      /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_middle.c ends */
      /* ************************************************************* */

      /* Double switch state / signal */
      RTDS_transitionExecuted = 1;
      switch(RTDS_currentContext->sdlState)
        {
        /* Transitions for state READY */
        case RTDS_state_READY:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state READY - message Sensor_MachinePickDone */
            case RTDS_message_Sensor_MachinePickDone:
              RTDS_MSG_RECEIVE_Sensor_MachinePickDone(          mid);
              if ( !((RTDS_BOOLEAN)(mid == myId)) )
                {
                RTDS_SDL_STATE_SET(RTDS_state_READY);
                break;
                }
              RTDS_MSG_SEND_Ack_Picked_TO_NAME("Supervisor", RTDS_process_Supervisor,               myId);
              RTDS_SET_TIMER(RTDS_message_T_PREP, 1000 * (0 + 10));
              RTDS_SDL_STATE_SET(RTDS_state_MACHINING);
              break;
            /* Transition for state READY - message Cmd_StopAll */
            case RTDS_message_Cmd_StopAll:
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state IDLE */
        case RTDS_state_IDLE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state IDLE - message Cmd_Prepare */
            case RTDS_message_Cmd_Prepare:
              RTDS_SDL_STATE_SET(RTDS_state_READY);
              break;
            /* Transition for state IDLE - message Cmd_StopAll */
            case RTDS_message_Cmd_StopAll:
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state MACHINING */
        case RTDS_state_MACHINING:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state MACHINING - message T_PREP */
            case RTDS_message_T_PREP:
              RTDS_MSG_SEND_Rpt_EndMachining_TO_NAME("Supervisor", RTDS_process_Supervisor,               myId);
              RTDS_SDL_STATE_SET(RTDS_state_WAIT_DROP_ORDER);
              break;
            /* Transition for state MACHINING - message Cmd_StopAll */
            case RTDS_message_Cmd_StopAll:
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state DROPPING */
        case RTDS_state_DROPPING:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state DROPPING - message Sensor_MachineDropDone */
            case RTDS_message_Sensor_MachineDropDone:
              RTDS_MSG_RECEIVE_Sensor_MachineDropDone(          mid);
              if ( !((RTDS_BOOLEAN)(mid == myId)) )
                {
                RTDS_SDL_STATE_SET(RTDS_state_DROPPING);
                break;
                }
              else if ( (RTDS_BOOLEAN)(mid == myId) )
                {
                RTDS_MSG_SEND_Ack_Dropped_TO_NAME("Supervisor", RTDS_process_Supervisor,                 myId);
                RTDS_SDL_STATE_SET(RTDS_state_IDLE);
                break;
                }
            /* Transition for state DROPPING - message Cmd_StopAll */
            case RTDS_message_Cmd_StopAll:
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state WAIT_DROP_ORDER */
        case RTDS_state_WAIT_DROP_ORDER:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_DROP_ORDER - message Cmd_DropToConv */
            case RTDS_message_Cmd_DropToConv:
              RTDS_SDL_STATE_SET(RTDS_state_DROPPING);
              break;
            /* Transition for state WAIT_DROP_ORDER - message Cmd_StopAll */
            case RTDS_message_Cmd_StopAll:
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        default:
          RTDS_transitionExecuted = 0;
          break;
        } /* End of switch(RTDS_currentContext->sdlState) */
      /* ************************************************************ */
      /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_end.c begins   */
      /* PragmaDev RTDS posix integration                             */
      RTDS_TransitionCleanUp( RTDS_currentContext , RTDS_sdlStatePrev );
      } /* End of if ( RTDS_currentContext->currentMessage != NULL )  */
    } /* End of for ( ; ; ) */

  /* $(RTDS_HOME)/share/ccg/posix/bricks/RTDS_Proc_end.c ends   */
  /* ********************************************************** */
  }
