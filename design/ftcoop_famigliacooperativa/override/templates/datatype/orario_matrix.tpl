{def $matrix = $attribute.content
	 $object = $attribute.object}

{if and(
	eq($matrix.rows.sequential[0].columns[0], ''),
	eq($matrix.rows.sequential[0].columns[1], ''),
	eq($matrix.rows.sequential[0].columns[2], ''),
	eq($matrix.rows.sequential[0].columns[3], ''),
	eq($matrix.rows.sequential[0].columns[4], ''),
	eq($matrix.rows.sequential[0].columns[5], ''),
	eq($matrix.rows.sequential[0].columns[1], '')
)}

    {if $object.data_map.note_orario.has_content}
        <h2><i class="fa fa-clock"></i> Orari</h2>
        {attribute_view_gui attribute=$object.data_map.note_orario}
    {/if}

{else}

    <h2><i class="fa fa-clock"></i> Orari <span></span></h2>    
    <table class="table" cellspacing="0" data-orario="{$object.id}">
        <tr>
            {foreach $matrix.columns.sequential as $column_name}
                <th data-week_date="{$column_name.identifier}">{$column_name.name|wash()}</th>
            {/foreach}
        </tr>
        {foreach $matrix.rows.sequential as $row}
            {def $count = 1}
            <tr>
                {foreach $row.columns as $column}
                    <td data-week_date="{$count}">{$column|wash( xhtml )}</td>
                    {set $count = $count|sum(1)}
                {/foreach}
            </tr>
            {undef $count}
        {/foreach}
    </table>
    
{/if}