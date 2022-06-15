REM =======================================================
REM cleanup section - Remove subscribers
REM =======================================================

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('SHIPPING',null,null)-
);

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('BILLING',null,null)-
);

execute dbms_aqadm.remove_subscriber ( -
	  queue_name => 'orders_queue', -
	  subscriber => sys.aq$_agent('RUSH_ORDER',null,null)-
);


REM =======================================================
REM cleanup section - drop queues
REM =======================================================
BEGIN
  dbms_aqadm.stop_queue(queue_name => 'orders_queue');
  dbms_aqadm.drop_queue (
        queue_name              => 'orders_queue');
  dbms_aqadm.drop_queue_table (
        queue_table => 'orders_queuetable');
END;
/

REM =======================================================
REM cleanup section - delete message type
REM =======================================================

DROP TYPE order_message_typ;

COMMIT;

