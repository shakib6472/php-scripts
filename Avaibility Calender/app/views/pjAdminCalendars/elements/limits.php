<div id="limits" class="tab-pane<?php echo $active_tab == 'limits' ? ' active' : NULL;?>">
    <div class="panel-body">
		<div class="panel-body-inner">
			<?php 
			$info = str_replace("[STAG]", "<a href='#' data-toggle='modal' data-target='#modalCopyLimits' class='btn btn-primary btn-outline'>", __('copyLimitsInfo', true));
			$info = str_replace("[ETAG]", "</a>", $info); 
			?>
			<div class="alert alert-success"><?php echo $info;?></div>
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminCalendars&amp;action=pjActionUpdate" method="post" id="frmUpdateLimits" class="form pj-form">
				<input type="hidden" name="calendar_update" value="1" />
        		<input type="hidden" name="tab" value="limits" />
        		<input type="hidden" name="tab_id" value="10" />
				<div class="table-responsive">
					<table class="table table-striped table-hover" id="tblLimits">
						<thead>
							<tr>
								<th><?php __('limit_from'); ?></th>
								<th><?php __('limit_to'); ?></th>
								<th><?php __('limit_min'); ?></th>
								<th><?php __('limit_max'); ?></th>
								<th>&nbsp;</th>
							</tr>
						</thead>		
						<tbody>
						<?php if ($tpl['limit_arr']) { ?>
							<?php foreach ($tpl['limit_arr'] as $limit) { ?>
								<tr>
									<td>
										<div class="input-group date">
											<input type="text" id="date_from_<?php echo $limit['id'];?>" name="date_from[<?php echo $limit['id'];?>]" data-idx="<?php echo $limit['id'];?>" value="<?php echo !empty($limit['date_from']) ? date($tpl['option_arr']['o_date_format'], strtotime($limit['date_from'])) : NULL;?>" class="form-control required datepick" readonly="readonly" data-msg-required="<?php __('pj_field_required', false, true);?>">
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</td>
			
									<td>
										<div class="input-group date">
											<input type="text" id="date_to_<?php echo $limit['id'];?>" name="date_to[<?php echo $limit['id'];?>]" data-idx="<?php echo $limit['id'];?>" value="<?php echo !empty($limit['date_to']) ? date($tpl['option_arr']['o_date_format'], strtotime($limit['date_to'])) : NULL;?>" class="form-control required datepick" readonly="readonly" data-msg-required="<?php __('pj_field_required', false, true);?>">
											<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</td>
			
									<td>
										<input class="touchspin3 form-control" type="text" value="<?php echo $limit['min_nights']; ?>" name="min_nights[<?php echo $limit['id'];?>]">
									</td>
			
									<td>
										<input class="touchspin3 form-control" type="text" value="<?php echo $limit['max_nights']; ?>" name="max_nights[<?php echo $limit['id'];?>]">
									</td>
			
									<td>
										<div class="text-right">
											<a href="#" class="btn btn-danger btn-outline btn-sm m-n lnkRemoveLimitRow"><i class="fa fa-trash"></i></a>
										</div>
									</td>
								</tr> 
							<?php } ?>	
						<?php } ?>
						</tbody>
					</table>
				</div>
	
				<button type="button" class="btn btn-primary btn-outline btnAddLimit"><i class="fa fa-plus"></i> <?php __('limit_add'); ?></button>
			
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
	
	<table style="display: none" id="tblLimitClone">
		<tbody>
			<tr>
				<td>
					<div class="input-group date">
						<input type="text" id="date_from_{INDEX}" name="date_from[{INDEX}]" value="<?php echo date($tpl['option_arr']['o_date_format']);?>" data-idx="{INDEX}" class="form-control required datepick" readonly="readonly" data-msg-required="<?php __('pj_field_required', false, true);?>">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</td>

				<td>
					<div class="input-group date">
						<input type="text" id="date_to_{INDEX}" name="date_to[{INDEX}]" value="<?php echo date($tpl['option_arr']['o_date_format']);?>" data-idx="{INDEX}" class="form-control required datepick" readonly="readonly" data-msg-required="<?php __('pj_field_required', false, true);?>">
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</td>

				<td>
					<input class="form-control" type="text" name="min_nights[{INDEX}]" id="min_nights_{INDEX}" value="1">
				</td>

				<td>
					<input class="form-control" type="text" name="max_nights[{INDEX}]" id="max_nights_{INDEX}" value="1">
				</td>

				<td>
					<div class="text-right">
						<a href="#" class="btn btn-danger btn-outline btn-sm m-n lnkRemoveLimitRow"><i class="fa fa-trash"></i></a>
					</div>
				</td>
			</tr> 
		</tbody>
	</table>
	
	<!-- Modal -->
	<div class="modal fade" id="modalCopyLimits" tabindex="-1" role="dialog" aria-labelledby="myCopyLimitsLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myCopyLimitsLabel"><?php __('modalCopyLimitsTitle');?></h4>
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
	            <input type="hidden" name="copy_tab_id" value="10" />
	            <input type="hidden" name="copy_tab" value="limits" />
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