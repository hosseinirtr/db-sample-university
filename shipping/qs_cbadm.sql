

REM =======================================================
REM create queue tables and queues
REM =======================================================
BEGIN
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_CBADM_orders_sqtab',
        comment =>
          'Customer Billing Single Consumer Orders queue table',
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
  dbms_aqadm.create_queue_table(
        queue_table => 'QS_CBADM_orders_mqtab',
        comment =>
          'Customer Billing Multi Consumer Service queue table',
        multiple_consumers => TRUE,
        queue_payload_type => 'QS_ADM.order_typ',
        compatible => '8.1');
  dbms_aqadm.create_queue (
        queue_name              => 'QS_CBADM_shippedorders_q',
        queue_table             => 'QS_CBADM_orders_sqtab');

END;
/

REM =======================================================
REM Grant dequeue privilege on the shopoeped orders queue to the Customer Billing
Rem application.  The QS_CB application retrieves shipped orders (not billed yet)
Rem from the shopoeped orders queue.
BEGIN
  dbms_aqadm.grant_queue_privilege(
    'DEQUEUE',
    'QS_CBADM_shippedorders_q',
    'QS_CB',
    FALSE);
END;
/

BEGIN
  dbms_aqadm.create_queue (
        queue_name              => 'QS_CBADM_billedorders_q',
        queue_table             => 'QS_CBADM_orders_mqtab');
END;
/

REM =======================================================
REM Grant enqueue privilege on the billed orders queue to Customer Billing
Rem application.  The QS_CB application is allowed to put billed orders into
Rem this queue.
BEGIN
  dbms_aqadm.grant_queue_privilege(
    'ENQUEUE',
    'QS_CBADM_billedorders_q',
    'QS_CB',
    FALSE);
END;
/

DECLARE
  subscriber     sys.aq$_agent;
BEGIN
  /* Subscribe to the BILLING billed orders queue */
  subscriber := sys.aq$_agent(
    'BILLED_ORDER',
    'QS_CS.QS_CS_billedorders_que',
    null);
  dbms_aqadm.add_subscriber(
    queue_name => 'QS_CBADM.QS_CBADM_billedorders_q',
    subscriber => subscriber);
END;
/

COMMIT;
