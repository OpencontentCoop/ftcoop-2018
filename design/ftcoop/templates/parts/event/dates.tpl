{def $from_year = cond( $item.data_map.from_time.has_content, $item.data_map.from_time.content.timestamp|datetime( custom, '%Y'), false() )
     $from_month = cond( $item.data_map.from_time.has_content, $item.data_map.from_time.content.timestamp|datetime( custom, '%m'), false() )
     $from_day = cond( $item.data_map.from_time.has_content, $item.data_map.from_time.content.timestamp|datetime( custom, '%j'), false() )
     $to_year = cond( $item.data_map.to_time.has_content, $item.data_map.to_time.content.timestamp|datetime( custom, '%Y'), false() )
     $to_month = cond( $item.data_map.to_time.has_content, $item.data_map.to_time.content.timestamp|datetime( custom, '%n'), false() )
     $to_day = cond( $item.data_map.to_time.has_content, $item.data_map.to_time.content.timestamp|datetime( custom, '%j'), false() )
     $same_day = false()
}

{if and( $from_year|eq( $to_year ), $from_month|eq( $to_month ), $from_day|eq( $to_day ) )}
  {set $same_day = true()}
{/if}
{* if $item.data_map.to_time.has_content|not()}
  {set $same_day = true()}
{/if*}
{if $same_day}
  <i class="far fa-calendar-alt"></i> {$item.data_map.from_time.content.timestamp|l10n( 'date' )}
	{* il confronto va fatto con datetime, perchè in inglese mezzanotte è "12am" *}
	{if $item.data_map.from_time.content.timestamp|datetime( 'custom', '%H:%i' )|ne(0)}
		<div class="time">
      <i class="far fa-clock"></i>
		{if $item.data_map.to_time.content.timestamp|datetime( 'custom', '%H:%i' )|ne(0)}
      dalle
      <em>{$item.data_map.from_time.content.timestamp|l10n( 'shorttime' )}</em>
      alle
			<em>{$item.data_map.to_time.content.timestamp|l10n( 'shorttime' )}</em>
    {else}
      {$item.data_map.from_time.content.timestamp|l10n( 'shorttime' )}
    {/if}
		</div>
  {/if}
{elseif $item.data_map.to_time.has_content}
  <i class="far fa-calendar-alt"></i>
  dal
  {$item.data_map.from_time.content.timestamp|l10n( 'shortdate' )}
  al
  {$item.data_map.to_time.content.timestamp|l10n( 'shortdate' )}
{else}
  <i class="far fa-calendar-alt"></i>
  {$item.data_map.from_time.content.timestamp|l10n( 'date' )}
  {if $item.data_map.from_time.content.timestamp|datetime( 'custom', '%H:%i' )|ne(0)}
    <div class="time"><i class="far fa-clock"></i> {$item.data_map.from_time.content.timestamp|l10n( 'shorttime' )}</div>
  {/if}
{/if}

{undef}