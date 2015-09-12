<?php
$params = array
(
    'get' => array()
);
$map = ConfigParserLib::get('category', 'category_map');
$v['product'] = FdHelperLib::crudApi('products/' . array_search($uri_data['category_name'], $map) . '/' . $uri_data['id'], $written_language_tag, $params);
$v['filter_rows'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'rows');
$v['attribute_value'] = FdHelperLib::crudApi('categories/' . $uri_data['category_name'] . '/attributes', $written_language_tag);
$v['unlimited'] = ConfigParserLib::get('wlp' , 'wlp[\'' . $written_language_tag .'\'][\'unlimited\']');
$v['attribute_name_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'attribute_name_wlp[\'' . $written_language_tag .'\']');
$v['category_name_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'name[\'' . $written_language_tag .'\']');

$uri_position = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'uri_position');

$v['uri_where'] = array(
);
$v['title'] = $v['product']['name'] . ' ' . $v['category_name_wlp'] . ' ';

$v['detail_attribute'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'detail_attribute');
$v['detail_attribute_name_wlp'] = ConfigParserLib::get('product/' . $uri_data['category_name'] , 'detail_attribute_name_wlp[\'' . $written_language_tag .'\']');

//$output[] = 'filter';
?>
