<?php
class LanguageLib
{
    private function __construct()
    {

    }

    public static function getWrittenLanguageTag()
    {
        $user_wlt = isset($_SERVER['HTTP_ACCEPT_LANGUAGE']) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';
        $map = ConfigParserLib::get('language', 'written_languages_tag_map');
        if(!empty($user_wlt) && isset($map[strtolower($user_wlt)]))
        {
            return $map[strtolower($user_wlt)];
        }
        return ConfigParserLib::get('language', 'default_written_language_tag');
    }

}
?>
