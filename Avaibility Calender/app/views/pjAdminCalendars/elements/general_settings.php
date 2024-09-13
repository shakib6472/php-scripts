<div id="general_settings" class="tab-pane<?php echo $active_tab == 'general_settings' ? ' active' : NULL;?>">
    <div class="panel-body form-horizontal">
		<div class="panel-body-inner">
			<?php 
			$info = str_replace("[STAG]", "<a href='#' data-toggle='modal' data-target='#modalCopyGeneralSettings' class='btn btn-primary btn-outline'>", __('copyGeneralSettingsInfo', true));
			$info = str_replace("[ETAG]", "</a>", $info); 
			?>
			<div class="alert alert-success"><?php echo $info;?></div>
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminCalendars&amp;action=pjActionUpdate" method="post" id="frmUpdateCalendar" class="form pj-form">
				<input type="hidden" name="calendar_update" value="1" />
        		<input type="hidden" name="tab" value="general_settings" />
        		<input type="hidden" name="tab_id" value="1" />
				<div class="form-group">
					<label class="col-sm-3 control-label"><?php __('lblName');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<?php
								foreach ($tpl['lp_arr'] as $v)
								{
									?>
									<div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 1 ? NULL : 'none'; ?>">
										<input type="text" class="form-control<?php echo (int) $v['is_default'] === 0 ? NULL : ' required'; ?>" name="i18n[<?php echo $v['id']; ?>][name]" value="<?php echo pjSanitize::html(@$tpl['arr']['i18n'][$v['id']]['name']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">	
										<?php if ($tpl['is_flag_ready']) : ?>
										<span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
										<?php endif; ?>
									</div>
									<?php 
								}
								?>
							</div>
						</div>
					</div>
				</div>
				<?php if (!$controller->isOwner()) { ?>
				<div class="form-group">
					<label class="col-sm-3 control-label"><?php __('lblOwner'); ?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<select name="user_id" id="user_id" class="form-control select-item required" data-msg-required="<?php __('pj_field_required');?>" data-placeholder="-- <?php __('lblChoose'); ?> --">
									<option value="">-- <?php __('lblChoose'); ?> --</option>
									<?php
									foreach ($tpl['user_arr'] as $v)
									{
										?><option value="<?php echo $v['id']; ?>" <?php echo $tpl['arr']['user_id'] == $v['id'] ? 'selected="selected"' : '';?>><?php echo pjSanitize::html($v['name']); ?></option><?php
									}
									?>
								</select>
							</div>
						</div>
					</div>
				</div>
				<?php } ?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_accept_bookings"><?php __('opt_o_show_prices');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="clearfix">
							<div class="switch onoffswitch-data pull-left">
								<div class="onoffswitch">
									<input class="onoffswitch-checkbox" id="o_show_prices" type="checkbox" name="o_show_prices" <?php echo 1 == $tpl['option_arr']['o_show_prices'] ? ' checked="checked"' : NULL;?>>
									<label class="onoffswitch-label" for="o_show_prices">
									<span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
									<span class="onoffswitch-switch"></span>
									</label>
								</div>
							</div>
						</div>
						<small class="help-block m-b-none"><?php __('opt_o_show_prices_desc');?></small>
						<input type="hidden" name="value-enum-o_show_prices" value="<?php echo '1|0::' . $tpl['option_arr']['o_show_prices'];?>">
					</div>
				</div>
	
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_accept_bookings"><?php __('opt_o_show_week_numbers');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="clearfix">
							<div class="switch onoffswitch-data pull-left">
								<div class="onoffswitch">
									<input class="onoffswitch-checkbox" id="o_show_week_numbers" type="checkbox" name="o_show_week_numbers" <?php echo 1 == $tpl['option_arr']['o_show_week_numbers'] ? ' checked="checked"' : NULL;?>>
									<label class="onoffswitch-label" for="o_show_week_numbers">
									<span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
									<span class="onoffswitch-switch"></span>
									</label>
								</div>
							</div>
						</div>
						<small class="help-block m-b-none"><?php __('opt_o_show_week_numbers_desc');?></small>
						<input type="hidden" name="value-enum-o_show_week_numbers" value="<?php echo '1|0::' . $tpl['option_arr']['o_show_week_numbers'];?>">
					</div>
				</div>
	
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_accept_bookings"><?php __('opt_o_show_legend');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="clearfix">
							<div class="switch onoffswitch-data pull-left">
								<div class="onoffswitch">
									<input class="onoffswitch-checkbox" id="o_show_legend" type="checkbox" name="o_show_legend" <?php echo 1 == $tpl['option_arr']['o_show_legend'] ? ' checked="checked"' : NULL;?>>
									<label class="onoffswitch-label" for="o_show_legend">
									<span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
									<span class="onoffswitch-switch"></span>
									</label>
								</div>
							</div>
						</div>
						<small class="help-block m-b-none"><?php __('opt_o_show_legend_desc');?></small>
						<input type="hidden" name="value-enum-o_show_legend" value="<?php echo '1|0::' . $tpl['option_arr']['o_show_legend'];?>">
					</div>
				</div>
				<?php 
				$days = __('days', true);
				$o_week_start_value = explode("::", $tpl['calendar_option_arr']['o_week_start']['value']);
                $o_week_start_enum = explode("|", $o_week_start_value[0]);
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_week_start"><?php __('opt_o_week_start');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_week_start" class="form-control">
							<?php
							foreach ($o_week_start_enum as $k => $el)
							{
								if ($o_week_start_value[1] == $el)
								{
									?><option value="<?php echo $o_week_start_value[0].'::'.$el; ?>" selected="selected"><?php echo $days[$el]; ?></option><?php
								} else {
									?><option value="<?php echo $o_week_start_value[0].'::'.$el; ?>"><?php echo $days[$el]; ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				<?php 
				$o_date_format_value = explode("::", $tpl['calendar_option_arr']['o_date_format']['value']);
                $o_date_format_enum = explode("|", $o_date_format_value[0]);
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_date_format"><?php __('opt_o_date_format');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_date_format" class="form-control">
							<?php
							foreach ($o_date_format_enum as $k => $el)
							{
								if ($o_date_format_value[1] == $el)
								{
									?><option value="<?php echo $o_date_format_value[0].'::'.$el; ?>" selected="selected"><?php echo $el; ?></option><?php
								} else {
									?><option value="<?php echo $o_date_format_value[0].'::'.$el; ?>"><?php echo $el; ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<?php 
				$o_month_year_format_value = explode("::", $tpl['calendar_option_arr']['o_month_year_format']['value']);
                $o_month_year_format_enum = explode("|", $o_month_year_format_value[0]);
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_month_year_format"><?php __('opt_o_month_year_format');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_month_year_format" class="form-control">
							<?php
							foreach ($o_month_year_format_enum as $k => $el)
							{
								if ($o_month_year_format_value[1] == $el)
								{
									?><option value="<?php echo $o_month_year_format_value[0].'::'.$el; ?>" selected="selected"><?php echo $el; ?></option><?php
								} else {
									?><option value="<?php echo $o_month_year_format_value[0].'::'.$el; ?>"><?php echo $el; ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<?php 
				$locations = array();
				$zones = timezone_identifiers_list();
				foreach ($zones as $zone_name)
				{
					$zone = explode('/', $zone_name);
					if(in_array($zone[0], array('Africa','America','Antarctica','Arctic','Asia','Atlantic','Australia','Europe','Indian','Pacific')))
					{
						$location_keys = array();
						$location_keys[] = $zone[0];
						if (isset($zone[1]) != '')
						{
							$location_keys[] = $zone[1];
							if (isset($zone[2]) != '')
							{
								$location_keys[] = $zone[2];
								$locations[$zone[0]][join('/', $location_keys)] = str_replace('_', ' ', $zone[1] . '/' . $zone[2]) . ' (UTC' . pjTimezone::getTimezoneOffset($zone_name) . ')';
							}else{
								$locations[$zone[0]][join('/', $location_keys)] = str_replace('_', ' ', $zone[1]) . ' (UTC' . pjTimezone::getTimezoneOffset($zone_name) . ')';
							}
						}
					}
				}
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_timezone"><?php __('opt_o_timezone');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_timezone" class="form-control">
							<?php
							foreach($locations as $continent => $cities)
							{
								?>
								<optgroup label="<?php echo pjSanitize::html($continent);?>">
									<?php
									foreach($cities as $pair => $city)
									{
										?>
										<option value="<?php echo $pair;?>"<?php echo $tpl['option_arr']['o_timezone'] == $pair ? ' selected="selected"' : NULL;?>><?php echo $city;?></option>
										<?php
									}
									?>
								</optgroup>
								<?php
							}
							?>
						</select>
					</div>
				</div>
				
				<?php 
				$o_currency_value = explode("::", $tpl['calendar_option_arr']['o_currency']['value']);
                $o_currency_enum = explode("|", $o_currency_value[0]);
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_currency"><?php __('opt_o_currency');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_currency" class="form-control">
							<?php
							foreach ($o_currency_enum as $k => $el)
							{
								if ($o_currency_value[1] == $el)
								{
									?><option value="<?php echo $o_currency_value[0].'::'.$el; ?>" selected="selected"><?php echo $el; ?></option><?php
								} else {
									?><option value="<?php echo $o_currency_value[0].'::'.$el; ?>"><?php echo $el; ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<?php 
				$default = explode("::", $tpl['calendar_option_arr']['o_send_email']['value']);
				$enum = explode("|", $default[0]);
				$enumLabels = array();
				if (!empty($tpl['calendar_option_arr']['o_send_email']['label']) && strpos($tpl['calendar_option_arr']['o_send_email']['label'], "|") !== false)
				{
					$enumLabels = explode("|", $tpl['calendar_option_arr']['o_send_email']['label']);
				}                                 
				?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="o_send_email"><?php __('opt_o_send_email');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_send_email" class="form-control">
							<?php
							foreach ($enum as $k => $el)
							{
								if ($default[1] == $el)
								{
									?><option value="<?php echo $default[0].'::'.$el; ?>" selected="selected"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								} else {
									?><option value="<?php echo $default[0].'::'.$el; ?>"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<div class="form-group pjSmtpSettings <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label"><?php __('opt_o_smtp_host');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control smtpRequiredFields <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? 'required' : '';?>" name="value-string-o_smtp_host" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_smtp_host']['value']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group pjSmtpSettings <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label"><?php __('opt_o_smtp_port');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control smtpRequiredFields" name="value-int-o_smtp_port" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_smtp_port']['value']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group pjSmtpSettings <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label"><?php __('opt_o_smtp_user');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control smtpRequiredFields <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? 'required' : '';?>" name="value-string-o_smtp_user" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_smtp_user']['value']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group pjSmtpSettings <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label"><?php __('opt_o_smtp_pass');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control" name="value-string-o_smtp_pass" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_smtp_pass']['value']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				<?php 
				$default = explode("::", $tpl['calendar_option_arr']['o_smtp_secure']['value']);
				$enum = explode("|", $default[0]);
				$enumLabels = array();
				if (!empty($tpl['calendar_option_arr']['o_smtp_secure']['label']) && strpos($tpl['calendar_option_arr']['o_smtp_secure']['label'], "|") !== false)
				{
					$enumLabels = explode("|", $tpl['calendar_option_arr']['o_smtp_secure']['label']);
				}                                 
				?>
				<div class="form-group pjSmtpSettings <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label" for="o_smtp_secure"><?php __('opt_o_smtp_secure');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_smtp_secure" class="form-control">
							<?php
							foreach ($enum as $k => $el)
							{
								if ($default[1] == $el)
								{
									?><option value="<?php echo $default[0].'::'.$el; ?>" selected="selected"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								} else {
									?><option value="<?php echo $default[0].'::'.$el; ?>"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<?php 
				$default = explode("::", $tpl['calendar_option_arr']['o_smtp_auth']['value']);
				$enum = explode("|", $default[0]);
				$enumLabels = array();
				if (!empty($tpl['calendar_option_arr']['o_smtp_auth']['label']) && strpos($tpl['calendar_option_arr']['o_smtp_auth']['label'], "|") !== false)
				{
					$enumLabels = explode("|", $tpl['calendar_option_arr']['o_smtp_auth']['label']);
				}                                 
				?>
				<div class="form-group pjSmtpSettings  <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label" for="o_smtp_auth"><?php __('opt_o_smtp_auth');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<select name="value-enum-o_smtp_auth" class="form-control">
							<?php
							foreach ($enum as $k => $el)
							{
								if ($default[1] == $el)
								{
									?><option value="<?php echo $default[0].'::'.$el; ?>" selected="selected"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								} else {
									?><option value="<?php echo $default[0].'::'.$el; ?>"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
								}
							}
							?>
						</select>
					</div>
				</div>
				
				<div class="form-group pjSmtpSettings  <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' ? '' : 'hidden';?>">
					<label class="col-sm-3 control-label" for="o_smtp_seder_email_same_as_username"><?php __('opt_o_smtp_seder_email_same_as_username');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="clearfix">
							<div class="switch onoffswitch-data pull-left">
								<div class="onoffswitch">
									<input class="onoffswitch-checkbox" id="o_smtp_seder_email_same_as_username" type="checkbox" name="o_smtp_seder_email_same_as_username" <?php echo 'Yes' == $tpl['option_arr']['o_smtp_seder_email_same_as_username'] ? ' checked="checked"' : NULL;?>>
									<label class="onoffswitch-label" for="o_smtp_seder_email_same_as_username">
									<span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
									<span class="onoffswitch-switch"></span>
									</label>
								</div>
							</div>
						</div>
						<input type="hidden" name="value-enum-o_smtp_seder_email_same_as_username" value="<?php echo 'Yes|No::' . $tpl['option_arr']['o_smtp_seder_email_same_as_username'];?>">
					</div>
				</div>
	
				<div class="form-group ">
					<label class="col-sm-3 control-label"><?php __('opt_o_sender_email');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control required email" name="value-string-o_sender_email" id="o_sender_email" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_sender_email']['value']); ?>" <?php echo $tpl['option_arr']['o_send_email'] == 'smtp' && $tpl['option_arr']['o_smtp_seder_email_same_as_username'] == 'Yes'? 'readonly="readonly"' : '';?> data-msg-required="<?php __('pj_field_required', false, true);?>" data-msg-email="<?php __('plugin_base_email_invalid', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group ">
					<label class="col-sm-3 control-label"><?php __('opt_o_sender_name');?>:</label>
					<div class="col-lg-5 col-sm-7">
						<div class="row">
							<div class="col-sm-10">
								<input type="text" class="form-control" name="value-string-o_sender_name" value="<?php echo pjSanitize::html($tpl['calendar_option_arr']['o_sender_name']['value']); ?>" data-msg-required="<?php __('pj_field_required', false, true);?>">
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="hr-line-dashed"></div>
	
				<div class="clearfix">
					<button type="submit" class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in" style="margin-right: 15px;">
						<span class="ladda-label"><?php __('btnSave'); ?></span>
						<?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
					</button>
					<a type="button" class="btn btn-white btn-lg pull-right" href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminCalendars&action=pjActionIndex"><?php __('btnCancel'); ?></a>
				</div>
			</form>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="modalCopyGeneralSettings" tabindex="-1" role="dialog" aria-labelledby="myCopyGeneralSettingsLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myCopyGeneralSettingsLabel"><?php __('modalCopyGeneralSettingsTitle');?></h4>
	      </div>
	      <div class="modal-body">
	        <div class="form-group">
	            <label class="control-label"><?php __('lblCopyFrom');?>:</label>
	
	            <select name="copy_calendar_id" class="form-control form-control-lg">
	                <?php
					foreach ($tpl['calendars'] as $calendar)
					{
						if ($calendar['id'] == $controller->getCalendarId())
						{
							continue;
						}
						?><option value="<?php echo $calendar['id']; ?>"><?php echo stripslashes($calendar['name']); ?></option><?php
					}
					?>
	            </select>
	            <input type="hidden" name="copy_tab_id" value="1" />
	            <input type="hidden" name="copy_tab" value="general_settings" />
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal"><?php __('btnClose');?></button>
	        <button type="button" class="ladda-button btn btn-primary btn-phpjabbers-loader btnCopyOptions" data-style="zoom-in" style="margin-right: 15px;">
				<span class="ladda-label"><?php __('btnCopy'); ?></span>
				<?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
			</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>