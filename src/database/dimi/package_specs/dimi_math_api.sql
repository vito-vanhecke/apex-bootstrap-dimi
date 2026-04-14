create or replace package dimi_math_api as
    function add_numbers (
        p_left  number,
        p_right number
    ) return number;

end dimi_math_api;
/


-- sqlcl_snapshot {"hash":"2e598b87e739bf0e2794835610a4e4773b5468a9","type":"PACKAGE_SPEC","name":"DIMI_MATH_API","schemaName":"DIMI","sxml":""}