set serveroutput on
exec ut_runner.rebuild_annotation_cache('DIMI')
begin
    ut.run('UT_DIMI_MATH_API');
end;
/
exit;
