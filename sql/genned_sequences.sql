DROP SEQUENCE MNR.TEST_SECTION_TRACKING_SEQ;
DROP SEQUENCE MNR.HIBERNATE_SEQUENCE;
SELECT 'CREATE SEQUENCE TEST_SECTION_TRACKING_SEQ MINVALUE 1 START WITH ' || MNR.TEST_SECTION_TRACKING_SEQ.NEXTVAL || ' INCREMENT BY 1 CACHE 20;' FROM DUAL
                                                                                 *
ERROR at line 1:
ORA-00942: table or view does not exist


SELECT 'CREATE SEQUENCE HIBERNATE_SEQUENCE MINVALUE 1 START WITH ' || MNR.HIBERNATE_SEQUENCE.NEXTVAL || ' INCREMENT BY 1 CACHE 20;' FROM DUAL
                                                                          *
ERROR at line 1:
ORA-00942: table or view does not exist


EXIT;
