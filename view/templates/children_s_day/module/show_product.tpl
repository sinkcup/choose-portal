<style type="text/css">
.module_filter ul li
{
    margin:0 0 0.5em 0;
}
.module_filter ul ul
{
    display:inline;
    margin:0 0 0 1em;
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
    width:8em;
    float:left;
}
.module_filter .preview_img div
{
    float:left;
}
</style>
<div class="module_filter">
    <p class="filter_title">规格参数</p>
    <div class="filter_detail">
        <div id="preview_img" class="preview_img">
        <?php
        foreach($v['product']['preview_img'] as $one)
        {
            echo '<div><img height="260" src="' . FdHelperLib::getImgUri($one, 'auto', '260') . '" alt="" />';
            echo '</div>';
        }
        ?>
        </div>
        <div class="clear">
        </div>
        <ul>
            <?php
                //循环行
                foreach($v['detail_attribute'] as $attribute_name)
                {
                    echo '<li><span class="filter_name">' . $v['detail_attribute_name_wlp'][$attribute_name] . '</span>';
                    if($attribute_name=='taobao_uri')
                    {
                        echo '<a target="_blank" href="' . $v['product'][$attribute_name] . '">' . $v['product'][$attribute_name] . '</a></li>';
                    }
                    else
                    {
                        echo $v['product'][$attribute_name] . '</li>';
                    }
                }
                foreach($v['filter_rows'] as $row)
                {
                    //如果这一行不是数组，说明是单选
                    if(!is_array($row))
                    {
                        $attribute_name = $row;
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$attribute_name] . '</span>';
                        echo '<ul class="one_column">';
                        foreach($v['attribute_value'][$attribute_name] as $value=>$value_display)
                        {
                            $tmp = $v['uri_where'];
                            $tmp[$attribute_name] = $value;
                            if($value==$v['product'][$attribute_name])
                            {
                                echo '<li>' . $value_display . '</li>';
                            }
                        }
                        echo '</ul></li>';
                    }
                    else
                    {
                        $tmp = array_keys($row);
                        $row_name = $tmp[0];
                        echo '<li><span class="filter_name">' . $v['attribute_name_wlp'][$row_name] . '</span>';
                        echo '<ul class="one_column">';
                        $tmp = array_values($row);

                        foreach($tmp[0] as $attribute_name)
                        {
                            if(1==$v['product'][$attribute_name])
                            {
                                echo '<li>' . $v['attribute_name_wlp'][$attribute_name] . '</li>';
                            }
                        }
                        echo '</ul></li>';
                    }
                }
            ?>
            </ul>
        </ul>
        <div class="clear">
        </div>
    </div>
</div>
