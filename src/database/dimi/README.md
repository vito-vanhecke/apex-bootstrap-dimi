# Database Object Examples

This directory contains empty folders for organizing database objects. Below are example files that demonstrate what each folder should contain.

## tables/demo_parent.sql

```sql
create table dimi.demo_parent (
    id         number default dimi.demo_seq.nextval,
    name       varchar2(100 byte) not null enable,
    created_at date default sysdate
);

alter table dimi.demo_parent
    add constraint demo_parent_name_chk check ( name is not null ) enable;

alter table dimi.demo_parent
    add constraint demo_parent_pk primary key ( id )
        using index enable;
```

## tables/demo_child.sql

```sql
create table dimi.demo_child (
    id          number generated always as identity not null enable,
    parent_id   number not null enable,
    description varchar2(200 byte)
);

alter table dimi.demo_child
    add constraint demo_child_pk primary key ( id )
        using index enable;
```

## views/demo_view.sql

```sql
create or replace force editionable view dimi.demo_view (
    id,
    name,
    description
) as
    select
        p.id,
        p.name,
        c.description
    from
        demo_parent p
        left join demo_child  c on c.parent_id = p.id;
```

## views/demo_duality_view.sql

```sql
create or replace force editionable json relational duality view dimi.demo_duality_view as
    select
        json{'_id' : p.id, 'name' : p.name}
    from
        demo_parent p
    with insert update delete;
```

## indexes/demo_child_parent_idx.sql

```sql
create index dimi.demo_child_parent_idx on
    dimi.demo_child (
        parent_id
    );
```

## ref_constraints/demo_child_parent_fk.sql

```sql
alter table dimi.demo_child
    add constraint demo_child_parent_fk
        foreign key ( parent_id )
            references dimi.demo_parent ( id )
        enable;
```

## sequences/demo_seq.sql

```sql
create sequence dimi.demo_seq minvalue 1 maxvalue 9999999999999999999999999999 increment by 1 cache 20 noorder
nocycle nokeep noscale global;
```

## triggers/demo_trigger.sql

```sql
create or replace editionable trigger dimi.demo_trigger before
    insert on dimi.demo_parent
    for each row
begin
    if :new.created_at is null then
        :new.created_at := sysdate;
    end if;
end demo_trigger;
/

alter trigger dimi.demo_trigger enable;
```

## functions/demo_func.sql

```sql
create or replace function dimi.demo_func (
    p_val number
) return number is
begin
    return p_val * 2;
end demo_func;
/
```

## procedures/demo_proc.sql

```sql
create or replace procedure dimi.demo_proc (
    p_name varchar2
) is
begin
    insert into demo_parent ( name ) values ( p_name );

end demo_proc;
/
```

## package_specs/demo_pkg.sql

```sql
create or replace package dimi.demo_pkg as
    function hello (
        p_name varchar2
    ) return varchar2;

    procedure do_nothing;

end demo_pkg;
/
```

## package_bodies/demo_pkg.sql

```sql
create or replace package body dimi.demo_pkg as

    function hello (
        p_name varchar2
    ) return varchar2 is
    begin
        return 'Hello, ' || p_name;
    end;

    procedure do_nothing is
    begin
        null;
    end;

end demo_pkg;
/
```

## type_specs/demo_type.sql

```sql
create or replace type dimi.demo_type as object (
        id   number,
        name varchar2(100),
        member function get_display return varchar2
);
/
```

## type_bodies/demo_type.sql

```sql
create or replace type body dimi.demo_type as
    member function get_display return varchar2 is
    begin
        return to_char(id)
               || ' - '
               || name;
    end;

end;
/
```

## synonyms/demo_syn.sql

```sql
create or replace editionable synonym dimi.demo_syn for dimi.demo_parent;
```

## materialized_views/demo_mview.sql

```sql
create materialized view dimi.demo_mview (
    id,
    name,
    created_at
) build immediate using index
    refresh force
    on demand
    with primary key
    using enforced constraints
    disable on query computation
    disable query rewrite
    disable concurrent refresh
as
    select
        id,
        name,
        created_at
    from
        demo_parent;
```

## mle_modules/demo_mle_module.sql

```sql
CREATE OR REPLACE MLE MODULE "DIMI"."DEMO_MLE_MODULE" 
   LANGUAGE JAVASCRIPT AS 
export function doubleIt(x) {
    return x * 2;
}
/
```

## mle_modules/demo_mle_module.js

```javascript
export function doubleIt(x) {
    return x * 2;
}
```

## mle_envs/demo_mle_env.sql

```sql
create or replace mle env dimi.demo_mle_env imports ( 'demo_mle_module' module dimi.demo_mle_module );
```

## ords/ords.sql

```sql
DECLARE
  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'dimi',
      p_auto_rest_auth      => FALSE);

  ORDS.DEFINE_MODULE(
      p_module_name    => 'demo_module',
      p_base_path      => '/demo/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => 'Demo ORDS module');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'demo_module',
      p_pattern        => 'parents',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'demo_module',
      p_pattern        => 'parents',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT id, name FROM demo_parent');

  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.DIMI');
  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.any.DIMI');
  l_roles(1) := 'oracle.dbtools.autorest.any.schema';
  l_roles(2) := 'oracle.dbtools.role.autorest.DIMI';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.dbtools.autorest.privilege.DIMI',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => 'DIMI metadata-catalog access',
      p_description    => 'Provides access to the metadata catalog of the objects in the DIMI schema.',
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

  l_roles(1) := 'SODA Developer';
  l_patterns(1) := '/soda/*';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.soda.privilege.developer',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

COMMIT;

END;
/
```

## aq_queue_tables/demo_qt.sql

```sql
begin
    sys.dbms_aqadm.create_queue_table(
        queue_table        => '"DIMI"."DEMO_QT"',
        queue_payload_type => 'RAW',
        compatible         => '10.0.0'
    );
end;
```

## aq_queues/demo_queue.sql

```sql
begin
    sys.dbms_aqadm.create_queue(
        queue_name          => '"DIMI"."DEMO_QUEUE"',
        queue_table         => '"DIMI"."DEMO_QT"',
        queue_type          => 0,
        max_retries         => 5,
        retry_delay         => 0,
        dependency_tracking => false
    );
end;
```

## apex_apps

Need to wait for apex lang, but right now can work with the /apex and /sqlcl skill by Oleksii Vykhristiyk
