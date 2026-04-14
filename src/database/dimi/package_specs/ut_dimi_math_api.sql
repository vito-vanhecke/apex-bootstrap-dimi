create or replace package ut_dimi_math_api as
  --%suite(DIMI Math API)

  --%suitepath(dimi.math)

  --%test(Adds two positive numbers)
    procedure adds_two_positive_numbers;

  --%test(Adds mixed sign numbers)
    procedure adds_mixed_sign_numbers;

  --%test(Treats null as zero)
    procedure treats_null_as_zero;

  --%test(Exports complex sample data)
    procedure exports_complex_sample_data;

end ut_dimi_math_api;
/


-- sqlcl_snapshot {"hash":"33caf4dac474278235e1cc823e87d185a58cf1d7","type":"PACKAGE_SPEC","name":"UT_DIMI_MATH_API","schemaName":"DIMI","sxml":""}