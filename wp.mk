%.wp: WP = $(FRAMAC) $(FCFLAGS) -wp -wp-rte
%.wp: PARSE_RESULT = $(word 1,$(subst ., ,$*)).parse
%.wp: $$(PARSE_RESULT) $$(shell $(DIR)cmd-dep.sh $$@/command $$(WP)) $(if $(BENCHMARK),.FORCE,)
	@$(call display_command,$(WP))
	mkdir -p $@
	mv -f $@/{command,running}
	{
	  $(call time_with_output,$@/stats.txt) \
	    $(WP) \
	      -load $(PARSE_RESULT)/framac.sav -save $@/framac.sav \
	      -kernel-log w:$@/warnings.log \
	      -from-log w:$@/warnings.log \
	      -inout-log w:$@/warnings.log \
	      -scope-log w:$@/warnings.log \
	      -wp-log w:$@/warnings.log \
	      -then \
	      -report-csv $@/alarms.csv -report-no-proven \
	      -report-log w:$@/warnings.log \
	      -metrics-log a:$@/metrics.log \
	    || ($(RM) $@/stats.txt && false) # Prevents having error code reporting in stats.txt
	} 2>&1 | tee $@/wp.log
	mv $@/{running,command}
	touch $@ # Update timestamp and prevents remake if nothing changes

clean::
	$(RM) -r *.wp
