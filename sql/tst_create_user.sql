drop user tst cascade;
create user tst identified by tst DEFAULT TABLESPACE users;
GRANT CREATE SESSION TO tst; 
GRANT UNLIMITED TABLESPACE TO TST;
grant create sequence to tst;
grant drop any sequence to tst;
grant create table to tst;
grant create any index to tst;
exit;