<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('infobOwnersTitle'); ?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infobOwnersDesc');?></p>
    </div><!-- /.col-md-12 -->
</div>

<div class="wrapper wrapper-content animated fadeInRight">
	<?php
	$error_code = $controller->_get->toString('err');
	if (!empty($error_code))
    {
    	$titles = __('error_titles', true);
    	$bodies = __('error_bodies', true);
    	switch (true)
    	{
    		case in_array($error_code, array('AOW01', 'AOW03')):
    			?>
    			<div class="alert alert-success">
    				<i class="fa fa-check m-r-xs"></i>
    				<strong><?php echo @$titles[$error_code]; ?></strong>
    				<?php echo @$bodies[$error_code]?>
    			</div>
    			<?php 
    			break;
            case in_array($error_code, array('AOW04', 'AOW08')):	
    			?>
    			<div class="alert alert-danger">
    				<i class="fa fa-exclamation-triangle m-r-xs"></i>
    				<strong><?php echo @$titles[$error_code]; ?></strong>
    				<?php echo @$bodies[$error_code]?>
    			</div>
    			<?php
    			break;
    	}
    }
    ?>
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div class="row m-b-md">
                        <div class="col-md-4 col-sm-4">
                        <?php 
                        if(pjAuth::factory('pjAdminOwners', 'pjActionCreate')->hasAccess())
                        {
                        	?>
                            <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOwners&amp;action=pjActionCreate" class="btn btn-primary"><i class="fa fa-plus"></i> <?php __('btnAddOwner');?></a>
                            <?php 
                        }
                        ?>
                        </div><!-- /.col-md-6 -->
    					<?php
    					if(pjAuth::factory('pjAdminOwners')->hasAccess())
    					{
        					?>
                            <div class="col-md-4 col-sm-8">
                            	<form action="" method="get" class="form-horizontal frm-filter">
    								<div class="input-group">
    									<input type="text" name="q" placeholder="<?php __('plugin_base_btn_search', false, true); ?>" class="form-control">
    									<div class="input-group-btn">
    										<button class="btn btn-primary" type="submit">
    											<i class="fa fa-search"></i>
    										</button>
    									</div>
    								</div>
    							</form>
                            </div><!-- /.col-md-3 -->
        
                            <div class="col-md-4 text-right">
                                <div class="btn-group" role="group" aria-label="...">
                                    <button type="button" class="btn btn-primary btn-all active"><?php __('plugin_base_lbl_all');?></button>
                                    <button type="button" class="btn btn-default btn-filter" data-column="status" data-value="T"><i class="fa fa-check"></i> <?php __('plugin_base_filter_ARRAY_active'); ?></button>
                                    <button type="button" class="btn btn-default btn-filter" data-column="status" data-value="F"><i class="fa fa-times"></i> <?php __('plugin_base_filter_ARRAY_inactive'); ?></button>
                                </div>
                            </div><!-- /.col-md-6 -->
                            <?php
    					}
                        ?>
                    </div>
    				<?php
    				if(pjAuth::factory('pjAdminOwners')->hasAccess())
    				{
        				?>
                        <div id="grid"></div>
                        <?php
    				}
                    ?>
                    
                </div>
            </div>
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
</div>

<script type="text/javascript">
var pjGrid = pjGrid || {};
pjGrid.jsDateFormat = "<?php echo pjUtil::jsDateFormat($tpl['option_arr']['o_date_format']); ?>";
pjGrid.currentUserId = <?php echo (int) $_SESSION[$controller->defaultUser]['id']; ?>;
pjGrid.has_update = <?php echo pjAuth::factory('pjAdminOwners', 'pjActionUpdate')->hasAccess() ? 'true' : 'false'; ?>;
pjGrid.has_delete = <?php echo pjAuth::factory('pjAdminOwners', 'pjActionDeleteOwner')->hasAccess() ? 'true' : 'false'; ?>;
pjGrid.has_delete_bulk = <?php echo pjAuth::factory('pjAdminOwners', 'pjActionDeleteOwnerBulk')->hasAccess() ? 'true' : 'false'; ?>;
var myLabel = myLabel || {};
myLabel.name = <?php x__encode('plugin_base_name'); ?>;
myLabel.email = <?php x__encode('plugin_base_email'); ?>;
myLabel.last_login = <?php x__encode('plugin_base_last_login'); ?>;
myLabel.status = <?php x__encode('plugin_base_status'); ?>;
myLabel.yesno = <?php x__encode('plugin_base_yesno'); ?>;
myLabel.active = <?php x__encode('plugin_base_filter_ARRAY_active'); ?>;
myLabel.inactive = <?php x__encode('plugin_base_filter_ARRAY_inactive'); ?>;
myLabel.delete_selected = <?php x__encode('plugin_base_delete_selected'); ?>;
myLabel.delete_confirmation = <?php x__encode('plugin_base_delete_confirmation'); ?>;
</script>