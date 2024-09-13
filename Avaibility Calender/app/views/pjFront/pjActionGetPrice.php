<?php
$payment_amount = 0;
if (isset($tpl['price_arr']) && is_array($tpl['price_arr']))
{
	$total = $tpl['price_arr']['amount'] + $tpl['price_arr']['tax'];
	$deposit = $tpl['price_arr']['deposit'];
	$nights = (int) $tpl['price_arr']['nights'];
	$sub_title = '';
	if ($tpl['option_arr']['o_price_based_on'] == 'days')
	{
		if($nights != 1)
		{
			$sub_title = str_replace("{DAYS}", $nights, __('front_for_days', true));
		}else{
			$sub_title = __('front_for_1_day', true);
		}
	}else{
		if($nights != 1)
		{
			$sub_title = str_replace("{NIGHTS}", $nights, __('front_for_nights', true));
		}else{
			$sub_title = __('front_for_1_nights', true);
		}
	}
	$option_arr = $tpl['option_arr'];	 
	?>
	<div class="abParagraph">
		<div class="abParagraphInner">
			<label class="abTitle"><?php __('bf_price'); ?><br /><span class="abSubTitle">(<?php echo $sub_title;?>)</span></label>
			<span class="abValue">
				<?php echo pjCurrency::formatPrice($tpl['price_arr']['amount']); ?>
				
			</span>
		</div>
	</div>

	
	<?php if ((float) $tpl['option_arr']['o_tax'] > 0) : ?>
	<div class="abParagraph">
		<div class="abParagraphInner">
			<label class="abTitle"><?php __('bf_tax'); ?> (<?php echo $tpl['option_arr']['o_tax']?>%)</label>
			<span class="abValue"><?php echo pjCurrency::formatPrice($tpl['price_arr']['tax']); ?></span>
		</div>
	</div>
	<?php endif; ?>
	<?php
	$sub_title_arr = array();
	if((float) $tpl['option_arr']['o_tax'] > 0)
	{
		$sub_title_arr[] = __('bf_tax', true);
	}
	?>
	<div class="abParagraph">
		<div class="abParagraphInner">
			<label class="abTitle abBold">
				<?php __('bf_total'); ?>
				<?php
				if(!empty($sub_title_arr))
				{
					?><br /><span class="abSubTitle">(<?php __('bf_price'); ?> + <?php echo join(" + ", $sub_title_arr); ?>)</span><?php
				} 
				?>
			</label>
			<span class="abValue abPrice"><?php echo pjCurrency::formatPrice($tpl['price_arr']['total']); ?></span>
		</div>
	</div>
	<div class="abParagraph">
		<div class="abParagraphInner">
			<label class="abTitle"><?php __('bf_deposit'); ?>
			<?php
			if (isset($tpl['option_arr']['o_require_all_within'])
				&& (int) $tpl['option_arr']['o_require_all_within'] > 0
				&& strtotime(date("Y-m-d")) + (int) $tpl['option_arr']['o_require_all_within'] * 86400 >= @$_SESSION[$controller->defaultCalendar]['start_dt'])
			{
				?>
				<br /><span class="abSubTitle">(<?php echo '100% ' . ' ' . __('front_from_total_price', true);?>)</span>
				<?php
			} elseif ($tpl['option_arr']['o_deposit_type'] == 'percent') {
				?>
				<br /><span class="abSubTitle">(<?php echo $tpl['option_arr']['o_deposit'] . '% ' . ' ' . __('front_from_total_price', true);?>)</span>
				<?php
			}
			?>
			</label>
			<span class="abValue"><?php echo pjCurrency::formatPrice($deposit); ?></span>
		</div>
	</div>
	<div class="abParagraph">
		<div class="abParagraphInner">
			<label class="abTitle abBold"><?php __('bf_payment_required'); ?></label>
			<span class="abValue abPrice"><?php echo pjCurrency::formatPrice($tpl['price_arr']['deposit']); ?></span>
		</div>
	</div>
	<div class="abParagraph"></div>
	<?php
	$payment_amount = (float)$tpl['price_arr']['deposit'];
}
?>
<input type="hidden" name="payment_amount" value="<?php echo $payment_amount;?>" />