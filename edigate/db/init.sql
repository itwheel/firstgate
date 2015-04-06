drop user edigate cascade;
create user edigate identified by edi_123;
grant create session to edigate;
grant resource to edigate;
grant create any view to edigate;

-- Create sequence 
create sequence SEQ_BATCH_ID
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 20;

-- Create table
create table log_batch
(
  id        number(10) not null,
  type      number(4),
  start_dte timestamp,
  end_dte   timestamp,
  proc_cont number(10)
)
;
-- Add comments to the table 
comment on table log_batch
  is '批处理日志表';
-- Add comments to the columns 
comment on column log_batch.type
  is '1: slsrpt; 2: invrpt; 3:pricat';
comment on column log_batch.start_dte
  is '开始时间';
comment on column log_batch.end_dte
  is '结束时间';
comment on column log_batch.proc_cont
  is '处理数量';

CREATE OR REPLACE TRIGGER "TR_BATCH_ID" 
  before insert on log_batch
  for each row
begin
  select seq_batch_id.nextval into :new.id from dual;
end;

/
ALTER TRIGGER "EDIGATE"."TR_BATCH_ID" ENABLE;