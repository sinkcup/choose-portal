<?php
$v['filter_rows'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'rows');
$v['attribute_value'] = FdHelperLib::crudApi('categories/' . $uri_data['category_name'] . '/attributes', $written_language_tag);
$v['unlimited'] = ConfigParserLib::get('wlp' , 'wlp[\'' . $written_language_tag .'\'][\'unlimited\']');
$v['attribute_name_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'attribute_name_wlp[\'' . $written_language_tag .'\']');
$v['attribute_name_title_tail_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'attribute_name_title_tail_wlp[\'' . $written_language_tag .'\']');
$v['category_name_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'name[\'' . $written_language_tag .'\']');

$uri_position = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'uri_position');
$v['uri_where_array'] = explode('-',$uri_data['where']);
$v['uri_where'] = array(
);
//第一个是页码
$v['uri_where']['page_num'] = !empty($v['uri_where_array'][0]) ? $v['uri_where_array'][0] : 1;
//第2个是排序
$v['uri_where']['order_by'] = isset($v['uri_where_array'][1]) ? $v['uri_where_array'][1] : 1;
//筛选参数从第3个开始。这样以后加参数不会导致旧uri无效。
//比如1-2-0-0，加个参数1-2-0-0-0，以前的uri还有效。
//如果页面放在最后，就坏了。0-0-2-1，加个参数变成0-0-0-2-1，以前的uri无效了。
$v['title'] = $v['category_name_wlp'] . ' ';
foreach($uri_position as $position=>$attribute_name)
{
    $p = $position + 2;
    $v['uri_where'][$attribute_name] = isset($v['uri_where_array'][$p]) ? $v['uri_where_array'][$p] : '00';
    if(isset($v['uri_where_array'][$p]) && ($v['uri_where_array'][$p]!=='00'))
    {
        $tail = isset($v['attribute_name_title_tail_wlp'][$attribute_name]) ? $v['attribute_name_title_tail_wlp'][$attribute_name] : '';
        if(isset($v['attribute_value'][$attribute_name][$v['uri_where_array'][$p]]))
        {
            //是单选，api给了文字，显示
            $v['title'] .= ' ' . $v['attribute_value'][$attribute_name][$v['uri_where_array'][$p]] . $tail;
        }
        else
        {
            //是多选，api不给值，自己显示文字
            $v['title'] .= ' ' . $v['attribute_name_wlp'][$attribute_name] . $tail;
        }
    }
}
//$output[] = 'filter';
?>
