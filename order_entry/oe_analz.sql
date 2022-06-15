

EXECUTE dbms_stats.gather_schema_stats( -
        'OE'                            ,       -
        granularity => 'ALL'            ,       -
        cascade => TRUE                 ,       -
        block_sample => TRUE            ); 

