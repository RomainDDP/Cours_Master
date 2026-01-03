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
#include "RobotFeed.h"
#include "RTDS_messages.h"
#include "RTDS_gen.h"

#define RTDS_PROCESS_NUMBER RTDS_process_RobotFeed
#define RTDS_PROCESS_NAME RobotFeed

/*
** PROCESS RobotFeed:
** ------------------
*/

RTDS_TASK_ENTRY_POINT(RobotFeed)
  {
  short RTDS_transitionExecuted;
  int RTDS_savedSdlState = 0;

  MachineId targetM = M1;
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

  #include "RobotFeed_tempVars.h"

  RTDS_myLocals[0] = (void*)&mid;
  RTDS_myLocals[1] = (void*)&targetM;
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
        /* Transitions for state IDLE */
        case RTDS_state_IDLE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state IDLE - message Cmd_Place */
            case RTDS_message_Cmd_Place:
              RTDS_MSG_RECEIVE_Cmd_Place(          mid);
              targetM = mid;

              RTDS_SDL_STATE_SET(RTDS_state_PLACING);
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
        /* Transitions for state PLACING */
        case RTDS_state_PLACING:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state PLACING - message Sensor_PlaceDone */
            case RTDS_message_Sensor_PlaceDone:
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Ack_PlaceDone, 0, NULL, "Supervisor", RTDS_process_Supervisor);
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            /* Transition for state PLACING - message Cmd_StopAll */
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
