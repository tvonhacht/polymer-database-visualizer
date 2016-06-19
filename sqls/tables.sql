-- Create DV_SETUP table
create table DV_SETUP
(
  dv_setup_id NUMBER not null,
  schema_id   NUMBER
);
-- Add comments to the columns
comment on column DV_SETUP.dv_setup_id
  is 'pk';
comment on column DV_SETUP.schema_id
  is 'when linked to a schema (sys.dba_users)';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_SETUP
  add constraint PK_DV_SETUP primary key (DV_SETUP_ID)
  using index;

-- Create DV_SCHEMA table
create table DV_SCHEMA
(
  dv_schema_id NUMBER not null,
  dv_setup_id  NUMBER not null,
  schema_id    NUMBER not null,
  left         NUMBER default 0 not null,
  top          NUMBER default 0 not null,
  width        NUMBER default 0 not null,
  height       NUMBER default 0 not null
);
-- Add comments to the columns
comment on column DV_SCHEMA.dv_schema_id
  is 'pk';
comment on column DV_SCHEMA.dv_setup_id
  is 'fk to dv_setup';
comment on column DV_SCHEMA.schema_id
  is 'fk to sys.dba_users';
comment on column DV_SCHEMA.left
  is 'left position of schema';
comment on column DV_SCHEMA.top
  is 'top position of schema';
comment on column DV_SCHEMA.width
  is 'width of schema';
comment on column DV_SCHEMA.height
  is 'height of schema';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_SCHEMA
  add constraint PK_DV_SCHEMA primary key (DV_SCHEMA_ID)
  using index;
alter table DV_SCHEMA
  add constraint FK_DV_SCHEMA_DV_SETUP foreign key (DV_SETUP_ID)
  references DV_SETUP (DV_SETUP_ID);

-- Create DV_TABLE table
create table DV_TABLE
(
  dv_table_id  NUMBER not null,
  dv_schema_id NUMBER not null,
  table_id     NUMBER not null,
  left         NUMBER default 0 not null,
  top          NUMBER default 0 not null
);
-- Add comments to the columns
comment on column DV_TABLE.dv_table_id
  is 'pk';
comment on column DV_TABLE.dv_schema_id
  is 'fk to dv_schema';
comment on column DV_TABLE.table_id
  is 'fk to sys.dba_objects';
comment on column DV_TABLE.left
  is 'left position of table';
comment on column DV_TABLE.top
  is 'left position of table';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_TABLE
  add constraint PK_DV_TABLE primary key (DV_TABLE_ID)
  using index;
alter table DV_TABLE
  add constraint FK_DV_TABLE_DV_SCHEMA foreign key (DV_SCHEMA_ID)
  references DV_SCHEMA (DV_SCHEMA_ID);

-- Create DV_COLUMN table
create table DV_COLUMN
(
  dv_column_id NUMBER not null,
  dv_table_id  NUMBER not null,
  column_id    NUMBER not null,
  order_id     NUMBER
);
-- Add comments to the columns
comment on column DV_COLUMN.dv_column_id
  is 'pk';
comment on column DV_COLUMN.dv_table_id
  is 'fk to dv_table_id';
comment on column DV_COLUMN.column_id
  is 'fk to sys.dba_all_columns';
comment on column DV_COLUMN.order_id
  is 'own order of columns';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_COLUMN
  add constraint PK_DV_COLUMN primary key (DV_COLUMN_ID);
alter table DV_COLUMN
  add constraint FK_DV_COLUMN_DV_TABLE foreign key (DV_TABLE_ID)
  references DV_TABLE (DV_TABLE_ID);

-- Create DV_CONSTRAINT table
create table DV_CONSTRAINT
(
  dv_constraint_id      NUMBER not null,
  dv_table_id           NUMBER not null,
  constraint_name       VARCHAR2(64) not null,
  is_connected_left     NUMBER(1),
  is_connected_left_ref NUMBER(1)
);
-- Add comments to the columns
comment on column DV_CONSTRAINT.dv_constraint_id
  is 'pk';
comment on column DV_CONSTRAINT.dv_table_id
  is 'fk to dv_table';
comment on column DV_CONSTRAINT.constraint_name
  is 'fk to sys.all_constraints';
comment on column DV_CONSTRAINT.is_connected_left
  is 'constraint is connected to the left on the table';
comment on column DV_CONSTRAINT.is_connected_left_ref
  is 'constraint is connected to the left on the reference table';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_CONSTRAINT
  add constraint PK_DV_CONSTRAINT primary key (DV_CONSTRAINT_ID)
  using index;
alter table DV_CONSTRAINT
  add constraint FK_DV_CONSTRAINT_DV_TABLE foreign key (DV_TABLE_ID)
  references DV_TABLE (DV_TABLE_ID);

-- Create DV_CONSTRAINT_POS table
create table DV_CONSTRAINT_POS
(
  dv_constraint_pos_id NUMBER not null,
  dv_constraint_id     NUMBER not null,
  x                    NUMBER not null,
  y                    NUMBER not null,
  order_id             NUMBER not null
);
-- Add comments to the columns
comment on column DV_CONSTRAINT_POS.dv_constraint_pos_id
  is 'pk';
comment on column DV_CONSTRAINT_POS.dv_constraint_id
  is 'fk to dv_constraint';
comment on column DV_CONSTRAINT_POS.x
  is 'position x';
comment on column DV_CONSTRAINT_POS.y
  is 'position y';
comment on column DV_CONSTRAINT_POS.order_id
  is 'order of constraint positions';
-- Create/Recreate primary, unique and foreign key constraints
alter table DV_CONSTRAINT_POS
  add constraint PK_DV_CONSTRAINT_POS primary key (DV_CONSTRAINT_POS_ID)
  using index;
alter table DV_CONSTRAINT_POS
  add constraint FK_DV_CONSTRAINT_POS_DV_CONS foreign key (DV_CONSTRAINT_ID)
  references DV_CONSTRAINT (DV_CONSTRAINT_ID);