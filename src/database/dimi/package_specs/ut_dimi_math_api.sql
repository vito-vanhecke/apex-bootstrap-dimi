create or replace package ut_dimi_math_api as
  --%suite(DIMI Math API)

  --%suitepath(dimi.math)

  --%test(Adds two positive numbers)
    procedure adds_two_positive_numbers;

  --%test(Adds mixed sign numbers)
    procedure adds_mixed_sign_numbers;

  --%test(Exports complex sample data)
    procedure exports_complex_sample_data;

end ut_dimi_math_api;
/


-- sqlcl_snapshot {"hash":"f262ab2be11247dfbe5af3ef677cf799d14ca5bf","type":"PACKAGE_SPEC","name":"UT_DIMI_MATH_API","schemaName":"DIMI","sxml":""}