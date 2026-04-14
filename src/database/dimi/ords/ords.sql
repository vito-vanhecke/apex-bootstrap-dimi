
--
        
DECLARE
  l_current_schema varchar(40);
  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  SELECT sys_context('USERENV', 'CURRENT_USER') INTO l_current_schema FROM dual;

  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => l_current_schema,
      p_auto_rest_auth      => FALSE);

  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.' || l_current_schema || '');
  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.any.' || l_current_schema || '');
  l_roles(1) := 'oracle.dbtools.autorest.any.schema';
  l_roles(2) := 'oracle.dbtools.role.autorest.' || l_current_schema || '';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.dbtools.autorest.privilege.' || l_current_schema || '',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => '' || l_current_schema || ' metadata-catalog access',
      p_description    => 'Provides access to the metadata catalog of the objects in the ' || l_current_schema || ' schema.',
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

  l_roles(1) := 'SODA Developer';
  l_patterns(1) := '/soda/*';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.soda.privilege.developer',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;


COMMIT;

END;
/


-- sqlcl_snapshot {"hash":"8ed6ab4328e83392171564075184e0907f940fce","type":"ORDS_SCHEMA","name":"ords","schemaName":"DIMI","sxml":""}