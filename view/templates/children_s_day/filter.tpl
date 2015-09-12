<style type="text/css">
.module_filter ul li
{
    margin:0 0 0.5em 0;
}
.module_filter ul ul
{
    display:inline;
    margin:0;
}
.module_filter ul ul li
{
    display:inline;
    margin:0 1em 0 0;
}
.module_filter ul ul li a.visiting
{
    background:#ccc;
}
.module_filter ul ul li a.multi
{
    background:#f8f8f8;
    border-radius:3px;
    border:1px solid #8E8F8F;
    width:1em;
    height:1em;
    display:inline-block;
}
.module_filter p.filter_title
{
    background:#7DA7F0;
    background:-moz-linear-gradient(top,#7DA7F0,#6993DC);
    background:-webkit-gradient(linear,left top,left bottom,color-stop(0.28,#7DA7F0),color-stop(0.72,#6993DC));
    border-radius:5px 5px 0 0;
    color:#fff;
    padding:2px 3px;
}
.module_filter .filter_detail
{
    border:1px solid #DDD;
    border-radius:0 0 5px 5px;
    padding:3px 4px 10px 4px;
}
.module_filter li span.filter_name
{
    width:6em;
    float:left;
}
</style>
<div class="module_filter">
    <p class="filter_title">筛选条件</p>
    <div class="filter_detail">
        <ul>
            <?php
                //循环行
                foreach($v['filter_rows'] as $row)
                {
                    //如果这一行不是数组，说明是单选
                    if(!is_array($row))
                    {
                        $attribute_name = $row;
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$attribute_name] . '</span>';
                        echo '<ul class="one_column">';
                        $tmp = array
                        (
                            '00' => $v['unlimited'],
                        );
                        foreach($v['attribute_value'][$attribute_name] as $key=>$value)
                        {
                            $tmp[$key] = $value;
                        }
                        $v['attribute_value'][$attribute_name] = $tmp;
                        //array_unshift($v['attribute_value'][$attribute_name],$v['unlimited']); //array_unshift会把int的key丢掉。所以不能用。
                        foreach($v['attribute_value'][$attribute_name] as $value=>$value_display)
                        {
                            $tmp = $v['uri_where'];
                            $tmp[$attribute_name] = $value;
                            echo '<li><a href="'.encodeFilterUri($uri_data,$tmp).'"';
                            if(strval($v['uri_where'][$attribute_name])===strval($value))
                            {
                                echo ' class="visiting"';
                            }
                            echo '>'.$value_display.'</a></li>';
                        }
                        echo '</ul></li>';
                    }
                    else
                    {
                        $tmp = array_keys($row);
                        $row_name = $tmp[0];
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$row_name] . '</span>';
                        echo '<ul class="one_column">';
                        $single = $v['uri_where'];
                        $tmp = array_values($row);
                        $unlimited = true;
                        $unlimited_data = $v['uri_where'];
                        foreach($tmp[0] as $attribute_name)
                        {
                            $single[$attribute_name] = '00';
                            $unlimited_data[$attribute_name] = '00';
                            if(strval($v['uri_where'][$attribute_name])!='00')
                            {
                                $unlimited = false;
                            }
                        }
                        echo '<li><a href="' . encodeFilterUri($uri_data,$unlimited_data). '"';
                        if($unlimited === true)
                        {
                            echo ' class="visiting"';
                        }
                        echo '>' . $v['unlimited'] . '</a></li>';
                        foreach($tmp[0] as $attribute_name)
                        {
                            $single_uri_where = $single;
                            $attribute_value = 1;
                            $single_uri_where[$attribute_name] = $attribute_value;
                            $multi_uri_where = $v['uri_where'];
                            $multi_uri_where[$attribute_name] = 1;
                            if(strval($v['uri_where'][$attribute_name])===strval($attribute_value))
                            {
                                $multi_uri_where[$attribute_name] = '00';
                            }
                            echo '<li><a class="multi" href="' . encodeFilterUri($uri_data,$multi_uri_where) . '"';
                            echo '>';
                            if($v['uri_where'][$attribute_name]==$attribute_value)
                            {
                                echo '√';
                            }
                            echo '</a>';
                            echo '<a href="' . encodeFilterUri($uri_data,$single_uri_where) . '"';
                            if(strval($v['uri_where'][$attribute_name])===strval($attribute_value))
                            {
                                echo ' class="visiting"';
                            }
                            echo '>' . $v['attribute_name_wlp'][$attribute_name] . '</a></li>';
                        }
                        echo '</ul></li>';
                    }
                }
            ?>
            </ul>
        </ul>
    </div>
</div>
