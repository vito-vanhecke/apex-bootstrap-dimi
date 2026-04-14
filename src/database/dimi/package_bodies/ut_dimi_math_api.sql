create or replace package body ut_dimi_math_api as

    procedure adds_two_positive_numbers is
    begin
        ut.expect(dimi_math_api.add_numbers(2, 3)).to_equal(5);
    end adds_two_positive_numbers;

    procedure adds_mixed_sign_numbers is
    begin
        ut.expect(dimi_math_api.add_numbers(9, -4)).to_equal(5);
    end adds_mixed_sign_numbers;

    procedure treats_null_as_zero is
    begin
        ut.expect(dimi_math_api.add_numbers(null, 5)).to_equal(5);

        ut.expect(dimi_math_api.add_numbers(4, null)).to_equal(4);

        ut.expect(dimi_math_api.add_numbers(null, null)).to_equal(0);

    end treats_null_as_zero;

    procedure exports_complex_sample_data is
        l_count number;
    begin
        select
            count(*)
        into l_count
        from
            dimi_samples
        where
                sample_id = - 1
            and sample_text is not null
            and dbms_lob.getlength(sample_blob) = 4;

        ut.expect(l_count).to_equal(1);
    end exports_complex_sample_data;

end ut_dimi_math_api;
/


-- sqlcl_snapshot {"hash":"d85e9119b34e29cf8c45a55846af32a0e1999b95","type":"PACKAGE_BODY","name":"UT_DIMI_MATH_API","schemaName":"DIMI","sxml":""}