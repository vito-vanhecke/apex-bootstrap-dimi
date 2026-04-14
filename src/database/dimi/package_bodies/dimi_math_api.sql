create or replace package body dimi_math_api as

    function add_numbers (
        p_left  number,
        p_right number
    ) return number is
    begin
        return p_left + p_right;
    end add_numbers;

end dimi_math_api;
/


-- sqlcl_snapshot {"hash":"cb7f4d2cd88975f1a0c47dc3462c08a25d336094","type":"PACKAGE_BODY","name":"DIMI_MATH_API","schemaName":"DIMI","sxml":""}