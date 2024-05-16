import os
import re
from pathlib import Path

ALL_MYSQL_SYS_VARS = [b"activate_all_roles_on_login",b"admin_address",b"admin_port",b"admin_ssl_ca",b"admin_ssl_capath",b"admin_ssl_cert",b"admin_ssl_cipher",b"admin_ssl_crl",b"admin_ssl_crlpath",b"admin_ssl_key",b"admin_tls_ciphersuites",b"admin_tls_version",b"audit_log_buffer_size",b"audit_log_compression",b"audit_log_connection_policy",b"audit_log_current_session",b"audit_log_database",b"audit_log_disable",b"audit_log_encryption",b"audit_log_exclude_accounts",b"audit_log_file",b"audit_log_filter_id",b"audit_log_flush",b"audit_log_flush_interval_seconds",b"audit_log_format",b"audit_log_format_unix_timestamp",b"audit_log_include_accounts",b"audit_log_max_size",b"audit_log_password_history_keep_days",b"audit_log_policy",b"audit_log_prune_seconds",b"audit_log_read_buffer_size",b"audit_log_rotate_on_size",b"audit_log_statement_policy",b"audit_log_strategy",b"authentication_fido_rp_id",b"authentication_kerberos_service_key_tab",b"authentication_kerberos_service_principal",b"authentication_ldap_sasl_auth_method_name",b"authentication_ldap_sasl_bind_base_dn",b"authentication_ldap_sasl_bind_root_dn",b"authentication_ldap_sasl_bind_root_pwd",b"authentication_ldap_sasl_ca_path",b"authentication_ldap_sasl_group_search_attr",b"authentication_ldap_sasl_group_search_filter",b"authentication_ldap_sasl_init_pool_size",b"authentication_ldap_sasl_log_status",b"authentication_ldap_sasl_max_pool_size",b"authentication_ldap_sasl_referral",b"authentication_ldap_sasl_server_host",b"authentication_ldap_sasl_server_port",b"authentication_ldap_sasl_tls",b"authentication_ldap_sasl_user_search_attr",b"authentication_ldap_simple_auth_method_name",b"authentication_ldap_simple_bind_base_dn",b"authentication_ldap_simple_bind_root_dn",b"authentication_ldap_simple_bind_root_pwd",b"authentication_ldap_simple_ca_path",b"authentication_ldap_simple_group_search_attr",b"authentication_ldap_simple_group_search_filter",b"authentication_ldap_simple_init_pool_size",b"authentication_ldap_simple_log_status",b"authentication_ldap_simple_max_pool_size",b"authentication_ldap_simple_referral",b"authentication_ldap_simple_server_host",b"authentication_ldap_simple_server_port",b"authentication_ldap_simple_tls",b"authentication_ldap_simple_user_search_attr",b"authentication_policy",b"authentication_windows_log_level",b"authentication_windows_use_principal_name",b"auto_generate_certs",b"auto_increment_increment",b"auto_increment_offset",b"autocommit",b"automatic_sp_privileges",b"avoid_temporal_upgrade",b"back_log",b"basedir",b"big_tables",b"bind_address",b"binlog_cache_size",b"binlog_checksum",b"binlog_direct_non_transactional_updates",b"binlog_encryption",b"binlog_error_action",b"binlog_expire_logs_auto_purge",b"binlog_expire_logs_seconds",b"binlog_format",b"binlog_group_commit_sync_delay",b"binlog_group_commit_sync_no_delay_count",b"binlog_gtid_simple_recovery",b"binlog_max_flush_queue_time",b"binlog_order_commits",b"binlog_rotate_encryption_master_key_at_startup",b"binlog_row_event_max_size",b"binlog_row_image",b"binlog_row_metadata",b"binlog_row_value_options",b"binlog_rows_query_log_events",b"binlog_stmt_cache_size",b"binlog_transaction_compression",b"binlog_transaction_compression_level_zstd",b"binlog_transaction_dependency_history_size",b"binlog_transaction_dependency_tracking",b"block_encryption_mode",b"build_id",b"bulk_insert_buffer_size",b"caching_sha2_password_auto_generate_rsa_keys",b"caching_sha2_password_digest_rounds",b"caching_sha2_password_private_key_path",b"caching_sha2_password_public_key_path",b"character_set_client",b"character_set_connection",b"character_set_database (note 1)",b"character_set_filesystem",b"character_set_results",b"character_set_server",b"character_set_system",b"character_sets_dir",b"check_proxy_users",b"clone_autotune_concurrency",b"clone_block_ddl",b"clone_buffer_size",b"clone_ddl_timeout",b"clone_delay_after_data_drop",b"clone_donor_timeout_after_network_failure",b"clone_enable_compression",b"clone_max_concurrency",b"clone_max_data_bandwidth",b"clone_max_network_bandwidth",b"clone_ssl_ca",b"clone_ssl_cert",b"clone_ssl_key",b"clone_valid_donor_list",b"collation_connection",b"collation_database (note 1)",b"collation_server",b"completion_type",b"component_scheduler.enabled",b"concurrent_insert",b"connect_timeout",b"connection_control_failed_connections_threshold",b"connection_control_max_connection_delay",b"connection_control_min_connection_delay",b"connection_memory_chunk_size",b"connection_memory_limit",b"core_file",b"create_admin_listener_thread",b"cte_max_recursion_depth",b"daemon_memcached_enable_binlog",b"daemon_memcached_engine_lib_name",b"daemon_memcached_engine_lib_path",b"daemon_memcached_option",b"daemon_memcached_r_batch_size",b"daemon_memcached_w_batch_size",b"datadir",b"debug",b"debug_sync",b"default_authentication_plugin",b"default_collation_for_utf8mb4",b"default_password_lifetime",b"default_storage_engine",b"default_table_encryption",b"default_tmp_storage_engine",b"default_week_format",b"delay_key_write",b"delayed_insert_limit",b"delayed_insert_timeout",b"delayed_queue_size",b"disabled_storage_engines",b"disconnect_on_expired_password",b"div_precision_increment",b"dragnet.log_error_filter_rules",b"end_markers_in_json",b"enforce_gtid_consistency",b"enterprise_encryption.maximum_rsa_key_size",b"enterprise_encryption.rsa_support_legacy_padding",b"eq_range_index_dive_limit",b"error_count",b"event_scheduler",b"expire_logs_days",b"explain_format",b"explicit_defaults_for_timestamp",b"external_user",b"flush",b"flush_time",b"foreign_key_checks",b"ft_boolean_syntax",b"ft_max_word_len",b"ft_min_word_len",b"ft_query_expansion_limit",b"ft_stopword_file",b"general_log",b"general_log_file",b"generated_random_password_length",b"global_connection_memory_limit",b"global_connection_memory_tracking",b"group_concat_max_len",b"group_replication_advertise_recovery_endpoints",b"group_replication_allow_local_lower_version_join",b"group_replication_auto_increment_increment",b"group_replication_autorejoin_tries",b"group_replication_bootstrap_group",b"group_replication_clone_threshold",b"group_replication_communication_debug_options",b"group_replication_communication_max_message_size",b"group_replication_communication_stack",b"group_replication_components_stop_timeout",b"group_replication_compression_threshold",b"group_replication_consistency",b"group_replication_enforce_update_everywhere_checks",b"group_replication_exit_state_action",b"group_replication_flow_control_applier_threshold",b"group_replication_flow_control_certifier_threshold",b"group_replication_flow_control_hold_percent",b"group_replication_flow_control_max_quota",b"group_replication_flow_control_member_quota_percent",b"group_replication_flow_control_min_quota",b"group_replication_flow_control_min_recovery_quota",b"group_replication_flow_control_mode",b"group_replication_flow_control_period",b"group_replication_flow_control_release_percent",b"group_replication_force_members",b"group_replication_group_name",b"group_replication_group_seeds",b"group_replication_gtid_assignment_block_size",b"group_replication_ip_allowlist",b"group_replication_ip_whitelist",b"group_replication_local_address",b"group_replication_member_expel_timeout",b"group_replication_member_weight",b"group_replication_message_cache_size",b"group_replication_paxos_single_leader",b"group_replication_poll_spin_loops",b"group_replication_recovery_complete_at",b"group_replication_recovery_compression_algorithms",b"group_replication_recovery_get_public_key",b"group_replication_recovery_public_key_path",b"group_replication_recovery_reconnect_interval",b"group_replication_recovery_retry_count",b"group_replication_recovery_ssl_ca",b"group_replication_recovery_ssl_capath",b"group_replication_recovery_ssl_cert",b"group_replication_recovery_ssl_cipher",b"group_replication_recovery_ssl_crl",b"group_replication_recovery_ssl_crlpath",b"group_replication_recovery_ssl_key",b"group_replication_recovery_ssl_verify_server_cert",b"group_replication_recovery_tls_ciphersuites",b"group_replication_recovery_tls_version",b"group_replication_recovery_use_ssl",b"group_replication_recovery_zstd_compression_level",b"group_replication_single_primary_mode",b"group_replication_ssl_mode",b"group_replication_start_on_boot",b"group_replication_tls_source",b"group_replication_transaction_size_limit",b"group_replication_unreachable_majority_timeout",b"group_replication_view_change_uuid",b"gtid_executed",b"gtid_executed_compression_period",b"gtid_mode",b"gtid_next",b"gtid_owned",b"gtid_purged",b"have_compress",b"have_dynamic_loading",b"have_geometry",b"have_openssl",b"have_profiling",b"have_query_cache",b"have_rtree_keys",b"have_ssl",b"have_statement_timeout",b"have_symlink",b"histogram_generation_max_mem_size",b"host_cache_size",b"hostname",b"identity",b"immediate_server_version",b"information_schema_stats_expiry",b"init_connect",b"init_file",b"init_replica",b"init_slave",b"innodb_adaptive_flushing",b"innodb_adaptive_flushing_lwm",b"innodb_adaptive_hash_index",b"innodb_adaptive_hash_index_parts",b"innodb_adaptive_max_sleep_delay",b"innodb_api_bk_commit_interval",b"innodb_api_disable_rowlock",b"innodb_api_enable_binlog",b"innodb_api_enable_mdl",b"innodb_api_trx_level",b"innodb_autoextend_increment",b"innodb_autoinc_lock_mode",b"innodb_background_drop_list_empty",b"innodb_buffer_pool_chunk_size",b"innodb_buffer_pool_debug",b"innodb_buffer_pool_dump_at_shutdown",b"innodb_buffer_pool_dump_now",b"innodb_buffer_pool_dump_pct",b"innodb_buffer_pool_filename",b"innodb_buffer_pool_in_core_file",b"innodb_buffer_pool_instances",b"innodb_buffer_pool_load_abort",b"innodb_buffer_pool_load_at_startup",b"innodb_buffer_pool_load_now",b"innodb_buffer_pool_size",b"innodb_change_buffer_max_size",b"innodb_change_buffering",b"innodb_change_buffering_debug",b"innodb_checkpoint_disabled",b"innodb_checksum_algorithm",b"innodb_cmp_per_index_enabled",b"innodb_commit_concurrency",b"innodb_compress_debug",b"innodb_compression_failure_threshold_pct",b"innodb_compression_level",b"innodb_compression_pad_pct_max",b"innodb_concurrency_tickets",b"innodb_data_file_path",b"innodb_data_home_dir",b"innodb_ddl_buffer_size",b"innodb_ddl_log_crash_reset_debug",b"innodb_ddl_threads",b"innodb_deadlock_detect",b"innodb_dedicated_server",b"innodb_default_row_format",b"innodb_directories",b"innodb_disable_sort_file_cache",b"innodb_doublewrite",b"innodb_doublewrite_batch_size",b"innodb_doublewrite_dir",b"innodb_doublewrite_files",b"innodb_doublewrite_pages",b"innodb_extend_and_initialize",b"innodb_fast_shutdown",b"innodb_fil_make_page_dirty_debug",b"innodb_file_per_table",b"innodb_fill_factor",b"innodb_flush_log_at_timeout",b"innodb_flush_log_at_trx_commit",b"innodb_flush_method",b"innodb_flush_neighbors",b"innodb_flush_sync",b"innodb_flushing_avg_loops",b"innodb_force_load_corrupted",b"innodb_force_recovery",b"innodb_fsync_threshold",b"innodb_ft_aux_table",b"innodb_ft_cache_size",b"innodb_ft_enable_diag_#print(",b"innodb_ft_enable_stopword",b"innodb_ft_max_token_size",b"innodb_ft_min_token_size",b"innodb_ft_num_word_optimize",b"innodb_ft_result_cache_limit",b"innodb_ft_server_stopword_table",b"innodb_ft_sort_pll_degree",b"innodb_ft_total_cache_size",b"innodb_ft_user_stopword_table",b"innodb_idle_flush_pct",b"innodb_io_capacity",b"innodb_io_capacity_max",b"innodb_limit_optimistic_insert_debug",b"innodb_lock_wait_timeout",b"innodb_log_buffer_size",b"innodb_log_checkpoint_fuzzy_now",b"innodb_log_checkpoint_now",b"innodb_log_checksums",b"innodb_log_compressed_pages",b"innodb_log_file_size",b"innodb_log_files_in_group",b"innodb_log_group_home_dir",b"innodb_log_spin_cpu_abs_lwm",b"innodb_log_spin_cpu_pct_hwm",b"innodb_log_wait_for_flush_spin_hwm",b"innodb_log_write_ahead_size",b"innodb_log_writer_threads",b"innodb_lru_scan_depth",b"innodb_max_dirty_pages_pct",b"innodb_max_dirty_pages_pct_lwm",b"innodb_max_purge_lag",b"innodb_max_purge_lag_delay",b"innodb_max_undo_log_size",b"innodb_merge_threshold_set_all_debug",b"innodb_monitor_disable",b"innodb_monitor_enable",b"innodb_monitor_reset",b"innodb_monitor_reset_all",b"innodb_numa_interleave",b"innodb_old_blocks_pct",b"innodb_old_blocks_time",b"innodb_online_alter_log_max_size",b"innodb_open_files",b"innodb_optimize_fulltext_only",b"innodb_page_cleaners",b"innodb_page_size",b"innodb_parallel_read_threads",b"innodb_#print(_all_deadlocks",b"innodb_#print(_ddl_logs",b"innodb_purge_batch_size",b"innodb_purge_rseg_truncate_frequency",b"innodb_purge_threads",b"innodb_random_read_ahead",b"innodb_read_ahead_threshold",b"innodb_read_io_threads",b"innodb_read_only",b"innodb_redo_log_archive_dirs",b"innodb_redo_log_capacity",b"innodb_redo_log_encrypt",b"innodb_replication_delay",b"innodb_rollback_on_timeout",b"innodb_rollback_segments",b"innodb_saved_page_number_debug",b"innodb_segment_reserve_factor",b"innodb_sort_buffer_size",b"innodb_spin_wait_delay",b"innodb_spin_wait_pause_multiplier",b"innodb_stats_auto_recalc",b"innodb_stats_include_delete_marked",b"innodb_stats_method",b"innodb_stats_on_metadata",b"innodb_stats_persistent",b"innodb_stats_persistent_sample_pages",b"innodb_stats_transient_sample_pages",b"innodb_status_output",b"innodb_status_output_locks",b"innodb_strict_mode",b"innodb_sync_array_size",b"innodb_sync_debug",b"innodb_sync_spin_loops",b"innodb_table_locks",b"innodb_temp_data_file_path",b"innodb_temp_tablespaces_dir",b"innodb_thread_concurrency",b"innodb_thread_sleep_delay",b"innodb_tmpdir",b"innodb_trx_purge_view_update_only_debug",b"innodb_trx_rseg_n_slots_debug",b"innodb_undo_directory",b"innodb_undo_log_encrypt",b"innodb_undo_log_truncate",b"innodb_undo_tablespaces",b"innodb_use_fdatasync",b"innodb_use_native_aio",b"innodb_validate_tablespace_paths",b"innodb_version",b"innodb_write_io_threads",b"insert_id",b"interactive_timeout",b"internal_tmp_disk_storage_engine",b"internal_tmp_mem_storage_engine",b"join_buffer_size",b"keep_files_on_create",b"key_buffer_size",b"key_cache_age_threshold",b"key_cache_block_size",b"key_cache_division_limit",b"keyring_aws_cmk_id",b"keyring_aws_conf_file",b"keyring_aws_data_file",b"keyring_aws_region",b"keyring_encrypted_file_data",b"keyring_encrypted_file_password",b"keyring_file_data",b"keyring_hashicorp_auth_path",b"keyring_hashicorp_ca_path",b"keyring_hashicorp_caching",b"keyring_hashicorp_commit_auth_path",b"keyring_hashicorp_commit_ca_path",b"keyring_hashicorp_commit_caching",b"keyring_hashicorp_commit_role_id",b"keyring_hashicorp_commit_server_url",b"keyring_hashicorp_commit_store_path",b"keyring_hashicorp_role_id",b"keyring_hashicorp_secret_id",b"keyring_hashicorp_server_url",b"keyring_hashicorp_store_path",b"keyring_oci_ca_certificate",b"keyring_oci_compartment",b"keyring_oci_encryption_endpoint",b"keyring_oci_key_file",b"keyring_oci_key_finger#print(",b"keyring_oci_management_endpoint",b"keyring_oci_master_key",b"keyring_oci_secrets_endpoint",b"keyring_oci_tenancy",b"keyring_oci_user",b"keyring_oci_vaults_endpoint",b"keyring_oci_virtual_vault",b"keyring_okv_conf_dir",b"keyring_operations",b"large_files_support",b"large_page_size",b"large_pages",b"last_insert_id",b"lc_messages",b"lc_messages_dir",b"lc_time_names",b"license",b"local_infile",b"lock_order",b"lock_order_debug_loop",b"lock_order_debug_missing_arc",b"lock_order_debug_missing_key",b"lock_order_debug_missing_unlock",b"lock_order_dependencies",b"lock_order_extra_dependencies",b"lock_order_output_directory",b"lock_order_#print(_txt",b"lock_order_trace_loop",b"lock_order_trace_missing_arc",b"lock_order_trace_missing_key",b"lock_order_trace_missing_unlock",b"lock_wait_timeout",b"locked_in_memory",b"log_bin",b"log_bin_basename",b"log_bin_index",b"log_bin_trust_function_creators",b"log_bin_use_v1_row_events",b"log_error",b"log_error_services",b"log_error_suppression_list",b"log_error_verbosity",b"log_output",b"log_queries_not_using_indexes",b"log_raw",b"log_replica_updates",b"log_slave_updates",b"log_slow_admin_statements",b"log_slow_extra",b"log_slow_replica_statements",b"log_slow_slave_statements",b"log_statements_unsafe_for_binlog",b"log_syslog",b"log_syslog_facility",b"log_syslog_include_pid",b"log_syslog_tag",b"log_throttle_queries_not_using_indexes",b"log_timestamps",b"long_query_time",b"low_priority_updates",b"lower_case_file_system",b"lower_case_table_names",b"mandatory_roles",b"master_info_repository",b"master_verify_checksum",b"max_allowed_packet",b"max_binlog_cache_size",b"max_binlog_size",b"max_binlog_stmt_cache_size",b"max_connect_errors",b"max_connections",b"max_delayed_threads",b"max_digest_length",b"max_error_count",b"max_execution_time",b"max_heap_table_size",b"max_insert_delayed_threads",b"max_join_size",b"max_length_for_sort_data",b"max_points_in_geometry",b"max_prepared_stmt_count",b"max_relay_log_size",b"max_seeks_for_key",b"max_sort_length",b"max_sp_recursion_depth",b"max_user_connections",b"max_write_lock_count",b"mecab_rc_file",b"metadata_locks_cache_size",b"metadata_locks_hash_instances",b"min_examined_row_limit",b"myisam_data_pointer_size",b"myisam_max_sort_file_size",b"myisam_mmap_size",b"myisam_recover_options",b"myisam_repair_threads",b"myisam_sort_buffer_size",b"myisam_stats_method",b"myisam_use_mmap",b"mysql_firewall_mode",b"mysql_firewall_trace",b"mysql_native_password_proxy_users",b"mysqlx_bind_address",b"mysqlx_compression_algorithms",b"mysqlx_connect_timeout",b"mysqlx_deflate_default_compression_level",b"mysqlx_deflate_max_client_compression_level",b"mysqlx_document_id_unique_prefix",b"mysqlx_enable_hello_notice",b"mysqlx_idle_worker_thread_timeout",b"mysqlx_interactive_timeout",b"mysqlx_lz4_default_compression_level",b"mysqlx_lz4_max_client_compression_level",b"mysqlx_max_allowed_packet",b"mysqlx_max_connections",b"mysqlx_min_worker_threads",b"mysqlx_port",b"mysqlx_port_open_timeout",b"mysqlx_read_timeout",b"mysqlx_socket",b"mysqlx_ssl_ca",b"mysqlx_ssl_capath",b"mysqlx_ssl_cert",b"mysqlx_ssl_cipher",b"mysqlx_ssl_crl",b"mysqlx_ssl_crlpath",b"mysqlx_ssl_key",b"mysqlx_wait_timeout",b"mysqlx_write_timeout",b"mysqlx_zstd_default_compression_level",b"mysqlx_zstd_max_client_compression_level",b"named_pipe",b"named_pipe_full_access_group",b"ndb_allow_copying_alter_table",b"ndb_applier_allow_skip_epoch",b"ndb_autoincrement_prefetch_sz",b"ndb_batch_size",b"ndb_blob_read_batch_bytes",b"ndb_blob_write_batch_bytes",b"ndb_clear_apply_status",b"ndb_cluster_connection_pool",b"ndb_cluster_connection_pool_nodeids",b"ndb_conflict_role",b"ndb_data_node_neighbour",b"ndb_dbg_check_shares",b"ndb_default_column_format",b"ndb_default_column_format",b"ndb_deferred_constraints",b"ndb_deferred_constraints",b"ndb_distribution",b"ndb_distribution",b"ndb_eventbuffer_free_percent",b"ndb_eventbuffer_max_alloc",b"ndb_extra_logging",b"ndb_force_send",b"ndb_fully_replicated",b"ndb_index_stat_enable",b"ndb_index_stat_option",b"ndb_join_pushdown",b"ndb_log_apply_status",b"ndb_log_apply_status",b"ndb_log_bin",b"ndb_log_binlog_index",b"ndb_log_empty_epochs",b"ndb_log_empty_epochs",b"ndb_log_empty_update",b"ndb_log_empty_update",b"ndb_log_exclusive_reads",b"ndb_log_exclusive_reads",b"ndb_log_fail_terminate",b"ndb_log_orig",b"ndb_log_orig",b"ndb_log_transaction_compression",b"ndb_log_transaction_compression_level_zstd",b"ndb_log_transaction_dependency",b"ndb_log_transaction_id",b"ndb_log_transaction_id",b"ndb_log_update_as_write",b"ndb_log_update_minimal",b"ndb_log_updated_only",b"ndb_metadata_check",b"ndb_metadata_check_interval",b"ndb_metadata_sync",b"ndb_optimization_delay",b"ndb_optimized_node_selection",b"ndb_read_backup",b"ndb_recv_thread_activation_threshold",b"ndb_recv_thread_cpu_mask",b"ndb_replica_batch_size",b"ndb_replica_blob_write_batch_bytes",b"Ndb_replica_max_replicated_epoch",b"ndb_report_thresh_binlog_epoch_slip",b"ndb_report_thresh_binlog_mem_usage",b"ndb_row_checksum",b"ndb_schema_dist_lock_wait_timeout",b"ndb_schema_dist_timeout",b"ndb_schema_dist_timeout",b"ndb_schema_dist_upgrade_allowed",b"ndb_show_foreign_key_mock_tables",b"ndb_slave_conflict_role",b"Ndb_system_name",b"ndb_table_no_logging",b"ndb_table_temporary",b"ndb_use_copying_alter_table",b"ndb_use_exact_count",b"ndb_use_transactions",b"ndb_version",b"ndb_version_string",b"ndb_wait_connected",b"ndb_wait_setup",b"ndbinfo_database",b"ndbinfo_max_bytes",b"ndbinfo_max_rows",b"ndbinfo_offline",b"ndbinfo_show_hidden",b"ndbinfo_table_prefix",b"ndbinfo_version",b"net_buffer_length",b"net_read_timeout",b"net_retry_count",b"net_write_timeout",b"new",b"ngram_token_size",b"offline_mode",b"old",b"old_alter_table",b"open_files_limit",b"optimizer_prune_level",b"optimizer_search_depth",b"optimizer_switch",b"optimizer_trace",b"optimizer_trace_features",b"optimizer_trace_limit",b"optimizer_trace_max_mem_size",b"optimizer_trace_offset",b"original_commit_timestamp",b"original_server_version",b"parser_max_mem_size",b"partial_revokes",b"password_history",b"password_require_current",b"password_reuse_interval",b"performance_schema",b"performance_schema_accounts_size",b"performance_schema_digests_size",b"performance_schema_error_size",b"performance_schema_events_stages_history_long_size",b"performance_schema_events_stages_history_size",b"performance_schema_events_statements_history_long_size",b"performance_schema_events_statements_history_size",b"performance_schema_events_transactions_history_long_size",b"performance_schema_events_transactions_history_size",b"performance_schema_events_waits_history_long_size",b"performance_schema_events_waits_history_size",b"performance_schema_hosts_size",b"performance_schema_max_cond_classes",b"performance_schema_max_cond_instances",b"performance_schema_max_digest_length",b"performance_schema_max_digest_sample_age",b"performance_schema_max_file_classes",b"performance_schema_max_file_handles",b"performance_schema_max_file_instances",b"performance_schema_max_index_stat",b"performance_schema_max_memory_classes",b"performance_schema_max_metadata_locks",b"performance_schema_max_mutex_classes",b"performance_schema_max_mutex_instances",b"performance_schema_max_prepared_statements_instances",b"performance_schema_max_program_instances",b"performance_schema_max_rwlock_classes",b"performance_schema_max_rwlock_instances",b"performance_schema_max_socket_classes",b"performance_schema_max_socket_instances",b"performance_schema_max_sql_text_length",b"performance_schema_max_stage_classes",b"performance_schema_max_statement_classes",b"performance_schema_max_statement_stack",b"performance_schema_max_table_handles",b"performance_schema_max_table_instances",b"performance_schema_max_table_lock_stat",b"performance_schema_max_thread_classes",b"performance_schema_max_thread_instances",b"performance_schema_session_connect_attrs_size",b"performance_schema_setup_actors_size",b"performance_schema_setup_objects_size",b"performance_schema_show_processlist",b"performance_schema_users_size",b"persist_only_admin_x509_subject",b"persist_sensitive_variables_in_plaintext",b"persisted_globals_load",b"pid_file",b"plugin_dir",b"port",b"preload_buffer_size",b"#print(_identified_with_as_hex",b"profiling",b"profiling_history_size",b"protocol_compression_algorithms",b"protocol_version",b"proxy_user",b"pseudo_replica_mode",b"pseudo_slave_mode",b"pseudo_thread_id",b"query_alloc_block_size",b"query_prealloc_size",b"rand_seed1",b"rand_seed2",b"range_alloc_block_size",b"range_optimizer_max_mem_size",b"rbr_exec_mode",b"read_buffer_size",b"read_only",b"read_rnd_buffer_size",b"regexp_stack_limit",b"regexp_time_limit",b"relay_log",b"relay_log_basename",b"relay_log_index",b"relay_log_info_file",b"relay_log_info_repository",b"relay_log_purge",b"relay_log_recovery",b"relay_log_space_limit",b"replica_allow_batching",b"replica_checkpoint_group",b"replica_checkpoint_period",b"replica_compressed_protocol",b"replica_exec_mode",b"replica_load_tmpdir",b"replica_max_allowed_packet",b"replica_net_timeout",b"replica_parallel_type",b"replica_parallel_workers",b"replica_pending_jobs_size_max",b"replica_preserve_commit_order",b"replica_skip_errors",b"replica_sql_verify_checksum",b"replica_transaction_retries",b"replica_type_conversions",b"replication_optimize_for_static_plugin_config",b"replication_sender_observe_commit_only",b"report_host",b"report_password",b"report_port",b"report_user",b"require_row_format",b"require_secure_transport",b"resultset_metadata",b"rewriter_enabled",b"rewriter_enabled_for_threads_without_privilege_checks",b"rewriter_verbose",b"rpl_read_size",b"rpl_semi_sync_master_enabled",b"rpl_semi_sync_master_timeout",b"rpl_semi_sync_master_trace_level",b"rpl_semi_sync_master_wait_for_slave_count",b"rpl_semi_sync_master_wait_no_slave",b"rpl_semi_sync_master_wait_point",b"rpl_semi_sync_replica_enabled",b"rpl_semi_sync_replica_trace_level",b"rpl_semi_sync_slave_enabled",b"rpl_semi_sync_slave_trace_level",b"rpl_semi_sync_source_enabled",b"rpl_semi_sync_source_timeout",b"rpl_semi_sync_source_trace_level",b"rpl_semi_sync_source_wait_for_replica_count",b"rpl_semi_sync_source_wait_no_replica",b"rpl_semi_sync_source_wait_point",b"rpl_stop_replica_timeout",b"rpl_stop_slave_timeout",b"schema_definition_cache",b"secondary_engine_cost_threshold",b"secure_file_priv",b"select_into_buffer_size",b"select_into_disk_sync",b"select_into_disk_sync_delay",b"server_id",b"server_id_bits",b"server_uuid",b"session_track_gtids",b"session_track_schema",b"session_track_state_change",b"session_track_system_variables",b"session_track_transaction_info",b"sha256_password_auto_generate_rsa_keys",b"sha256_password_private_key_path",b"sha256_password_proxy_users",b"sha256_password_public_key_path",b"shared_memory",b"shared_memory_base_name",b"show_create_table_skip_secondary_engine",b"show_create_table_verbosity",b"show_gipk_in_create_table_and_information_schema",b"show_old_temporals",b"skip_external_locking",b"skip_name_resolve",b"skip_networking",b"skip_replica_start",b"skip_show_database",b"skip_slave_start",b"slave_allow_batching",b"slave_checkpoint_group",b"slave_checkpoint_period",b"slave_compressed_protocol",b"slave_exec_mode",b"slave_load_tmpdir",b"slave_max_allowed_packet",b"slave_net_timeout",b"slave_parallel_type",b"slave_parallel_workers",b"slave_pending_jobs_size_max",b"slave_preserve_commit_order",b"slave_rows_search_algorithms",b"slave_skip_errors",b"slave_sql_verify_checksum",b"slave_transaction_retries",b"slave_type_conversions",b"slow_launch_time",b"slow_query_log",b"slow_query_log_file",b"socket",b"sort_buffer_size",b"source_verify_checksum",b"sql_auto_is_null",b"sql_big_selects",b"sql_buffer_result",b"sql_generate_invisible_primary_key",b"sql_log_bin",b"sql_log_off",b"sql_mode",b"sql_notes",b"sql_quote_show_create",b"sql_replica_skip_counter",b"sql_require_primary_key",b"sql_safe_updates",b"sql_select_limit",b"sql_slave_skip_counter",b"sql_warnings",b"ssl_ca",b"ssl_capath",b"ssl_cert",b"ssl_cipher",b"ssl_crl",b"ssl_crlpath",b"ssl_fips_mode",b"ssl_key",b"ssl_session_cache_mode",b"ssl_session_cache_timeout",b"stored_program_cache",b"stored_program_definition_cache",b"super_read_only",b"sync_binlog",b"sync_master_info",b"sync_relay_log",b"sync_relay_log_info",b"sync_source_info",b"syseventlog.facility",b"syseventlog.include_pid",b"syseventlog.tag",b"system_time_zone",b"table_definition_cache",b"table_encryption_privilege_check",b"table_open_cache",b"table_open_cache_instances",b"tablespace_definition_cache",b"temptable_max_mmap",b"temptable_max_ram",b"temptable_use_mmap",b"terminology_use_previous",b"thread_cache_size",b"thread_handling",b"thread_pool_algorithm",b"thread_pool_dedicated_listeners",b"thread_pool_high_priority_connection",b"thread_pool_max_active_query_threads",b"thread_pool_max_transactions_limit",b"thread_pool_max_unused_threads",b"thread_pool_prio_kickup_timer",b"thread_pool_query_threads_per_group",b"thread_pool_size",b"thread_pool_stall_limit",b"thread_pool_transaction_delay",b"thread_stack",b"time_zone",b"timestamp",b"tls_ciphersuites",b"tls_version",b"tmp_table_size",b"tmpdir",b"transaction_alloc_block_size",b"transaction_allow_batching",b"transaction_isolation",b"transaction_prealloc_size",b"transaction_read_only",b"transaction_write_set_extraction",b"unique_checks",b"updatable_views_with_limit",b"use_secondary_engine",b"validate_password_check_user_name",b"validate_password_dictionary_file",b"validate_password_length",b"validate_password_mixed_case_count",b"validate_password_number_count",b"validate_password_policy",b"validate_password_special_char_count",b"validate_password.changed_characters_percentage",b"validate_password.check_user_name",b"validate_password.dictionary_file",b"validate_password.length",b"validate_password.mixed_case_count",b"validate_password.number_count",b"validate_password.policy",b"validate_password.special_char_count",b"version",b"version_comment",b"version_compile_machine",b"version_compile_os",b"version_compile_zlib",b"version_tokens_session",b"version_tokens_session_number",b"wait_timeout",b"warning_count",b"windowing_use_high_precision",b"xa_detach_on_prepare"]

SKIP_EXISTING = True
# TODO: mysql_inplace_upgrade.test
#       mysql-bug41486
#       create-big_myisam.test
#       filesort_debug.test
#       What to do with optimizer_switch as in func_in_icp?

timestamp_pattern = re.compile(b'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{6}Z')

logfile_first_line_pattern = re.compile(b'^/.*/mysqld, Version: 8.0.36 \(Source distribution\). started with:$')
logfile_second_line_pattern = re.compile(b'^Tcp port: [0-9]+  Unix socket.*$')
logfile_third_line_pattern = re.compile(b'^Time[\s]*Id[\s]*Command[\s]*Argument$')

set_general_log_file_off_pattern = re.compile(b"^.*SET\sGLOBAL\sgeneral_log.*=.*(\"|')OFF(\"|').*$", re.IGNORECASE)
set_general_log_output_table_pattern = re.compile(b"^.*SET\sGLOBAL\slog_output.*=.*(\"|')TABLE(\"|').*$", re.IGNORECASE)

wait_until_connected_pattern = re.compile(b"^--source include/(wait_until_connected_again|.*start.*).inc$")

mysql_test_path = '/home/stephanie/mysql-server/mysql-test/t' # TODO Only from /t, which suites to include?
mysql_build_path = '/home/stephanie/mysql-server/build'

temp_path = Path('temp_mysql')
temp_path.mkdir(exist_ok=True)

failed_file = open('failed.txt', 'w+')
failed_file.write('Extraction failed:\n')

def isBeginningOfLogFile(l):
    return logfile_first_line_pattern.match(l) \
        or logfile_second_line_pattern.match(l) \
        or logfile_third_line_pattern.match(l)

def lineContainsSysVar(l):
    if b"@@" in l:
        return True
    for var in ALL_MYSQL_SYS_VARS:
        if var in l:
            return True
    return False

def getNextLine(f, currLine):
    ##print(("getNextLine\n")
    l = f.readline()
    #print(("line")
    #print((l)
    #print(("re.match(b'.*Query\t$', l)")
    #print((re.match(b'.*Query\t$', l))
    while l and  (isBeginningOfLogFile(l) \
        or re.match(b'.*Query\t$', l) \
        or lineContainsSysVar(l) \
        or b"Connect\t" in l):
        l = f.readline()
        #print(("skipped line")
        #print((l)
    if b'shutdown' in currLine:
        return getNextLine(f, l) # two shutdowns after each other does not make sense
    return l

total_num_of_tests = 0
for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test' and filename != 'check-testcase.test' \
            and filename != 'windows_myisam.test' and filename != 'shm.test':
            total_num_of_tests += 1

test_num = 0
for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        test_path = Path('mysql_tests') / filepath.stem
        if SKIP_EXISTING and test_path.is_dir():
            continue
        if filepath.suffix == '.test' and filename != 'check-testcase.test' \
            and filename != 'windows_myisam.test' and filename != 'shm.test' and filename == 'invalid_collation.test': # TODO
            print(filepath)
            test_num += 1
            print(f"Extracting test ({test_num}\{total_num_of_tests})")
            with open(filepath.resolve(), "rb") as f1:
                file_bytes_lines = f1.readlines()
                log_file_path = temp_path / f"{filepath.stem}.log"
                prepend_lines = [b'SET GLOBAL log_output = "FILE";\n', \
                            (f'SET GLOBAL general_log_file = "{log_file_path.absolute()}";\n').encode(), \
                            b"SET GLOBAL general_log = 'ON';\n", \
                            b'SELECT "2024_automated_software_testing";\n']
                if not file_bytes_lines[3].startswith(b'SELECT "2024_automated_software_testing"'):
                    f2 = open(filepath.resolve(), "wb")
                    f2.writelines(prepend_lines)
                    for l in file_bytes_lines:
                        if set_general_log_file_off_pattern.match(l) \
                            or l.startswith(b"--remove_file"):
                            continue
                        l = re.sub(b"\$MYSQLTEST_VARDIR/[^\s]+.log", (f"{log_file_path.absolute()}").encode(), l)
                        if set_general_log_output_table_pattern.match(l):
                            l = b"SET GLOBAL log_output= \"TABLE,FILE\";"
                        f2.write(l)
                        if wait_until_connected_pattern.match(l):
                            f2.writelines(prepend_lines[:-1])
                    f2.close()
            os.system(f"{mysql_build_path}/mysql-test/mysql-test-run {filepath.stem} --fast > /dev/null") #     TODO: Ensure it is executed on one thread, log output?
            test_path.mkdir(exist_ok=True, parents=True)
            test_path = test_path / 'test.sql'
            test_file = open(test_path.resolve(), 'wb+')
            try:
                with open(log_file_path.resolve(), "rb") as f:
                    f.readline()
                    f.readline()
                    f.readline()
                    b1 = f.readline()
                    b2 = f.readline()
                    if prepend_lines[-2][:-2] not in b1 or prepend_lines[-1][:-2] not in b2:
                        raise Exception('Test is skipped')
                    i = 0
                    query = None
                    l0 = b""
                    l1 = getNextLine(f, l0)
                    if l1:
                        l2 = getNextLine(f, l1)
                    while True:
                        i += 1
                        if i > 1:
                            ##print(("Inside swap")
                            l0 = l1
                            l1 = l2
                            l2 = l3
                        #print(("l0: ")
                        #print((l0)
                        #print(("\n")
                        #print(("l1: ")
                        #print((l1)
                        #print(("\n")
                        #print(("l2: ")
                        #print((l2)
                        #print(("\n")
                        if not l1:
                            test_file.write(b";")
                            #print(("1")
                            break
                        if l2:
                            l3 = getNextLine(f, l2)
                            #print(("l3: ")
                            #print((l3)
                            #print(("\n")
                        if b"SET SQL_LOG_BIN = 0" in l1.upper() \
                            and (b"USE mtr" in l2 or b"use mtr" in l2):
                            #print(("2")
                            break
                        if b"SHOW WARNINGS" in l1.upper() and b"Quit" in l2 and not l3: # b"DROP" in l0 and 
                            #print(("HERE")
                            #print((l0)
                            query0 = l0.split(b'\t')[2].strip()
                            if query0:
                                test_file.write(b"\n"+query0+b";")
                            #print(("3")
                            break
                        split = l1.split(b'\t')
                        if (timestamp_pattern.match(split[0])):
                            if i>1 and query:
                                #print((query)
                                #print(("HERE2222222")
                                test_file.write(query + b';')
                            if b'Query' not in split[1]:
                                query = None
                                continue
                            query = split[2].strip()
                            if re.match(b"^[\s]*$", query):
                                query = None
                                continue
                            if i>1:
                                query = b"\n" + query;
                        else:
                            if query:
                                query += b"\n"+split[0].strip()
            except Exception as e:
                os.remove(test_path.resolve())
                if test_path.parent.exists():
                    test_path.parent.rmdir()
                ##print((e)
                failed_file.write(f"{filepath.resolve()}\n")
            test_file.close()
failed_file.close()