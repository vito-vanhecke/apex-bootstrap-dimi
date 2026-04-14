create or replace package body dimi_math_api as

    function add_numbers (
        p_left  number,
        p_right number
    ) return number is
    begin
        return nvl(p_left, 0) + nvl(p_right, 0);
    end add_numbers;

end dimi_math_api;
/


-- sqlcl_snapshot {"hash":"1ced6a03a8b0c305e7f64ee83609cf87407e1aca","type":"PACKAGE_BODY","name":"DIMI_MATH_API","schemaName":"DIMI","sxml":""}