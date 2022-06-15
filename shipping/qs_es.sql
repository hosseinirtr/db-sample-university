REM =======================================================
REM Create a priority queue table for QS_ES shipping
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_ES_orders_mqtab',
        comment => 
'East Shipping Multi Consumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
END;
/

REM =======================================================
REM Create a FIFO queue tables for QS_ES shipping
REM =======================================================
BEGIN
   dbms_aqadm.create_queue_table(
        queue_table => 'QS_ES_orders_pr_mqtab',
        sort_list =>'priority,enq_time',
        comment => 
'East Shipping Priority Multi Consumer Orders queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
END;
/

REM =======================================================
REM Booked orders are stored in the priority queue table
REM =======================================================
BEGIN
   dbms_aqadm.create_queue (
        queue_name              => 'QS_ES_bookedorders_que',
        queue_table             => 'QS_ES_orders_pr_mqtab');
END;
/

REM =======================================================
REM Shipped orders and back orders are stored in the FIFO 
REM queue table
REM =======================================================
BEGIN
   dbms_aqadm.create_queue (
        queue_name              => 'QS_ES_shippedorders_que',
        queue_table             => 'QS_ES_orders_mqtab');
END;
/

BEGIN
   dbms_aqadm.create_queue (
        queue_name              => 'QS_ES_backorders_que',
        queue_table             => 'QS_ES_orders_mqtab');
END;
/

COMMIT;

