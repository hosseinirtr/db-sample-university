

DECLARE
  res BOOLEAN;
BEGIN
  res := DBMS_XDB.createFolder('/home/OE/xsd');
  res := DBMS_XDB.createFolder('/home/OE/xsl');
  res := DBMS_XDB.createFolder('/home/OE/PurchaseOrders');
END;
/
