CREATE SCHEMA bitcoin;
CREATE TABLE bitcoin.cursors 
(
    id         text not null constraint cursor_pk primary key,
    cursor     text,
    block_num  bigint,
    block_id   text
);

CREATE TABLE bitcoin.Deploy (
    id         text  not null constraint deploy_pk primary key,
    deployer   text,
    block      text,
    timestamp  text,
    token      text
);

CREATE TABLE bitcoin.token (
    id         text  not null constraint tokens_pk primary key,
    deployment   text,
    decimals      text,
    max_supply  text,
    symbol      text
);