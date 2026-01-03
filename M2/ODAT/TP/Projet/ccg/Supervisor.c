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
#include "Supervisor.h"
#include "RTDS_messages.h"
#include "RTDS_gen.h"

#define RTDS_PROCESS_NUMBER RTDS_process_Supervisor
#define RTDS_PROCESS_NAME Supervisor

/*
** PROCESS Supervisor:
** -------------------
*/

RTDS_TASK_ENTRY_POINT(Supervisor)
  {
  short RTDS_transitionExecuted;
  int RTDS_savedSdlState = 0;

  MachineId curM = M1, mid = M1;
  RTDS_BOOLEAN m1Free = FALSE, m2Free = FALSE;
  RTDS_MSG_DATA_DECL

  void * RTDS_myLocals[4];
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

  #include "Supervisor_tempVars.h"

  RTDS_myLocals[0] = (void*)&curM;
  RTDS_myLocals[1] = (void*)&m1Free;
  RTDS_myLocals[2] = (void*)&m2Free;
  RTDS_myLocals[3] = (void*)&mid;
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
        /* Transitions for state WAIT_PICK_DONE */
        case RTDS_state_WAIT_PICK_DONE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_PICK_DONE - message Ack_Picked */
            case RTDS_message_Ack_Picked:
              RTDS_MSG_RECEIVE_Ack_Picked(          mid);
              if ( !((RTDS_BOOLEAN)(mid == curM)) )
                {
                RTDS_SDL_STATE_SET(RTDS_state_WAIT_PICK_DONE);
                break;
                }
              RTDS_RESET_TIMER(RTDS_message_T_PICK);
              RTDS_SET_TIMER(RTDS_message_T_MACH, 1000 * (0 + 300));
              RTDS_SDL_STATE_SET(RTDS_state_WAIT_MACH_END);
              break;
            /* Transition for state WAIT_PICK_DONE - message T_PICK */
            case RTDS_message_T_PICK:
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Sys_Failure, 0, NULL, "Supervisor", RTDS_process_Supervisor);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotFeed", RTDS_process_RobotFeed);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotRemove", RTDS_process_RobotRemove);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine1", RTDS_process_Machine1);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine2", RTDS_process_Machine2);
              RTDS_SDL_STATE_SET(RTDS_state_FAILURE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state WAIT_PLACE_DONE */
        case RTDS_state_WAIT_PLACE_DONE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_PLACE_DONE - message Ack_PlaceDone */
            case RTDS_message_Ack_PlaceDone:
              RTDS_RESET_TIMER(RTDS_message_T_FEED);
              RTDS_SET_TIMER(RTDS_message_T_PICK, 1000 * (0 + 20));
              RTDS_SDL_STATE_SET(RTDS_state_WAIT_PICK_DONE);
              break;
            /* Transition for state WAIT_PLACE_DONE - message T_FEED */
            case RTDS_message_T_FEED:
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Sys_Failure, 0, NULL, "Supervisor", RTDS_process_Supervisor);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotFeed", RTDS_process_RobotFeed);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotRemove", RTDS_process_RobotRemove);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine1", RTDS_process_Machine1);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine2", RTDS_process_Machine2);
              RTDS_SDL_STATE_SET(RTDS_state_FAILURE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state WAIT_DROP_DONE */
        case RTDS_state_WAIT_DROP_DONE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_DROP_DONE - message Ack_Dropped */
            case RTDS_message_Ack_Dropped:
              RTDS_MSG_RECEIVE_Ack_Dropped(          mid);
              if ( !((RTDS_BOOLEAN)(curM == mid)) )
                {
                RTDS_SDL_STATE_SET(RTDS_state_WAIT_DROP_DONE);
                break;
                }
              else if ( (RTDS_BOOLEAN)(curM == mid) )
                {
                RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_Remove, 0, NULL, "RobotRemove", RTDS_process_RobotRemove);
                RTDS_SET_TIMER(RTDS_message_T_REMOVE, 1000 * (0 + 30));
                RTDS_SDL_STATE_SET(RTDS_state_WAIT_REMOVE_DONE);
                break;
                }
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state FAILURE */
        case RTDS_state_FAILURE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state FAILURE - message Sys_Failure */
            case RTDS_message_Sys_Failure:
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Sys_Failure, 0, NULL, "Supervisor", RTDS_process_Supervisor);
              RTDS_SDL_STATE_SET(RTDS_state_FAILURE);
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
            /* Transition for state IDLE - message NewPiece */
            case RTDS_message_NewPiece:
              if ( !(m1Free) )
                {
                if ( !(m2Free) )
                  {
                  RTDS_SDL_STATE_SET(RTDS_state_IDLE);
                  break;
                  }
                else if ( m2Free )
                  {
                  curM = M2;

                  m2Free = FALSE;

                  }
                }
              else if ( m1Free )
                {
                curM = M1;

                m1Free = FALSE;

                }
              if ( !((RTDS_BOOLEAN)(curM == M1)) )
                {
                RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_Prepare, 0, NULL, "Machine2", RTDS_process_Machine2);
                }
              else if ( (RTDS_BOOLEAN)(curM == M1) )
                {
                RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_Prepare, 0, NULL, "Machine1", RTDS_process_Machine1);
                }
              RTDS_MSG_SEND_Cmd_Place_TO_NAME("RobotFeed", RTDS_process_RobotFeed,               curM);
              RTDS_SET_TIMER(RTDS_message_T_FEED, 1000 * (0 + 30));
              RTDS_SDL_STATE_SET(RTDS_state_WAIT_PLACE_DONE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state WAIT_REMOVE_DONE */
        case RTDS_state_WAIT_REMOVE_DONE:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_REMOVE_DONE - message Ack_RemoveDone */
            case RTDS_message_Ack_RemoveDone:
              RTDS_RESET_TIMER(RTDS_message_T_REMOVE);
              if ( !((RTDS_BOOLEAN)(curM == M1)) )
                {
                m2Free = TRUE;

                }
              else if ( (RTDS_BOOLEAN)(curM == M1) )
                {
                (RTDS_BOOLEAN)(m1Free == TRUE);
                }
              RTDS_SDL_STATE_SET(RTDS_state_IDLE);
              break;
            /* Transition for state WAIT_REMOVE_DONE - message T_REMOVE */
            case RTDS_message_T_REMOVE:
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Sys_Failure, 0, NULL, "Supervisor", RTDS_process_Supervisor);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotFeed", RTDS_process_RobotFeed);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "RobotRemove", RTDS_process_RobotRemove);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine1", RTDS_process_Machine1);
              RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_StopAll, 0, NULL, "Machine2", RTDS_process_Machine2);
              RTDS_SDL_STATE_SET(RTDS_state_FAILURE);
              break;
            default:
              RTDS_transitionExecuted = 0;
              break;
            } /* End of switch on message */
          break;
        /* Transitions for state WAIT_MACH_END */
        case RTDS_state_WAIT_MACH_END:
          switch(RTDS_currentContext->currentMessage->messageNumber)
            {
            /* Transition for state WAIT_MACH_END - message Rpt_EndMachining */
            case RTDS_message_Rpt_EndMachining:
              RTDS_MSG_RECEIVE_Rpt_EndMachining(          mid);
              if ( !((RTDS_BOOLEAN)(mid == curM)) )
                {
                RTDS_SDL_STATE_SET(RTDS_state_WAIT_MACH_END);
                break;
                }
              else if ( (RTDS_BOOLEAN)(mid == curM) )
                {
                RTDS_RESET_TIMER(RTDS_message_T_MACH);
                if ( !((RTDS_BOOLEAN)(curM == M1)) )
                  {
                  RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_DropToConv, 0, NULL, "Machine2", RTDS_process_Machine2);
                  }
                else if ( (RTDS_BOOLEAN)(curM == M1) )
                  {
                  RTDS_MSG_QUEUE_SEND_TO_NAME(RTDS_message_Cmd_DropToConv, 0, NULL, "Machine1", RTDS_process_Machine1);
                  }
                RTDS_SDL_STATE_SET(RTDS_state_WAIT_DROP_DONE);
                break;
                }
            /* Transition for state WAIT_MACH_END - message T_MACH */
            case RTDS_message_T_MACH:
              if ( !((RTDS_BOOLEAN)(curM == M1)) )
                {
                m2Free = FALSE;

                }
              else if ( (RTDS_BOOLEAN)(curM == M1) )
                {
                m1Free = FALSE;

                }
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
