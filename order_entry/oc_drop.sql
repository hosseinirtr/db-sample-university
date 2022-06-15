

drop table categories_tab                       cascade constraints ;

drop view oc_customers;
drop view oc_corporate_customers;
drop view oc_orders;
drop view oc_inventories;
drop view oc_product_information;

drop type order_list_typ force;
drop type product_ref_list_typ force;
drop type subcategory_ref_list_typ force;
drop type leaf_category_typ force;
drop type composite_category_typ force;
drop type catalog_typ force;
drop type category_typ force;

drop type customer_typ force;
drop type corporate_customer_typ force;
drop type warehouse_typ force;
drop type order_item_typ force;
drop type order_item_list_typ force;
drop type order_typ force;
drop type inventory_typ force;
drop type inventory_list_typ force;
drop type product_information_typ force;

commit;

