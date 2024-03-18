CREATE SCHEMA bitcoin;
CREATE TABLE bitcoin.cursors 
(
    id         text not null constraint cursor_pk primary key,
    cursor     text,
    block_num  bigint,
    block_id   text
);

CREATE TABLE bitcoin.Deploy (
    id  text not null constraint tokens_pk primary key,
    token text,
    deployer numeric,
    timestamp text,
    block text,
    token_address text
);