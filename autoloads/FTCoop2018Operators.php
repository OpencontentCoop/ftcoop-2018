<?php

class FTCoop2018Operators
{

    private static $contextData;

    private static $operators = array(
        'ftcoop_pagedata' => array()
    );

    function operatorList()
    {
        return array_keys(self::$operators);
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return self::$operators;
    }

    function modify(
        eZTemplate $tpl,
        $operatorName,
        $operatorParameters,
        $rootNamespace,
        $currentNamespace,
        &$operatorValue,
        $namedParameters
    ) {
        switch ($operatorName) {
            case 'ftcoop_pagedata':

                if (self::$contextData === null) {

                    $data = array(
                        'require_container' => true,
                        'subsite_id' => 0,
                        'topmenu_template_uri' => false,
                        'is_homepage' => false,
                        'reverse_path_id_array' => array(),
                        'path_array' => array(),
                        'has_subheader' => false,
                        'show_breadcrumb' => true,
                        'show_login' => false,
                        'canonical_language_url' => false,
                        'canonical_url' => false,
                        'global_root_node' => (int)eZINI::instance('site.ini')->variable('SiteSettings',
                            'GlobalSiteRootNodeID'),
                        'root_node' => (int)eZINI::instance('content.ini')->variable('NodeSettings', 'RootNode'),
                        'is_global_root' => false,
                    );

                    $currentModuleParams = $GLOBALS['eZRequestedModuleParams'];
                    $request = array(
                        'module' => $currentModuleParams['module_name'],
                        'function' => $currentModuleParams['function_name'],
                        'parameters' => $currentModuleParams['parameters'],
                    );
                    $data['is_login_page'] = $request['module'] == 'user' && $request['function'] == 'login';
                    $data['is_register_page'] = $request['module'] == 'user' && $request['function'] == 'register';
                    $data['is_search_page'] = $request['module'] == 'content' && ( $request['function'] == 'search' || $request['function'] == 'advancedsearch' );
                    $data['is_edit'] = $request['module'] == 'content' && $request['function'] == 'edit';
                    $data['is_browse'] = $request['module'] == 'content' && $request['function'] == 'browse';
                    $data['is_view'] = !$data['is_edit'] && !$data['is_browse'];

                    if ($tpl->hasVariable('module_result')) {
                        $moduleResult = $tpl->variable('module_result');

                        $data['ui_context'] = $moduleResult['ui_context'];

                        if (isset($moduleResult['content_info'])) {

                            if (isset($moduleResult['content_info']['main_node_url_alias']) && $moduleResult['content_info']['main_node_url_alias']) {
                                $data['canonical_url'] = $moduleResult['content_info']['main_node_url_alias'];
                            }

                            if (isset($moduleResult['content_info']['persistent_variable'])
                                && is_array($moduleResult['content_info']['persistent_variable'])) {
                                $data = array_merge($data, $moduleResult['content_info']['persistent_variable']);
                            }
                        }

                        $path = ( isset($moduleResult['path']) && is_array($moduleResult['path']) ) ? $moduleResult['path'] : array();
                        $reversePath = array_reverse($path);
                        $subSiteNodeIdList = self::getSubSiteNodeList();
                        foreach ($reversePath as $key => $item) {
                            if (isset($item['node_id'])) {
                                $data['reverse_path_id_array'][] = $item['node_id'];
                                if (isset($subSiteNodeIdList[$item['node_id']]) && $data['subsite_id'] == 0) {
                                    $data['subsite_id'] = (int)$subSiteNodeIdList[$item['node_id']];
                                }
                            }
                        }
                        foreach ($path as $key => $item) {
                            $data['path_array'][] = $item;
                        }

                        if ($tpl->hasVariable('current_node_id')) {
                            $currentNodeId = (int)$tpl->variable('current_node_id');
                        } else if (isset($moduleResult['node_id'])) {
                            $currentNodeId = (int)$moduleResult['node_id'];
                        }

                        $data['current_node_id'] = (int)$currentNodeId;
                        if ($data['root_node'] == $currentNodeId) {
                            $data['is_homepage'] = true;
                        }

                        if ($data['global_root_node'] == $currentNodeId) {
                            $data['is_global_root'] = true;
                        }

                        if (isset($moduleResult['content_info']['main_node_url_alias']) && $moduleResult['content_info']['main_node_url_alias']) {
                            $data['canonical_url'] = $moduleResult['content_info']['main_node_url_alias'];
                        }
                    } else {
                        $data = array_merge($data, ezjscPackerTemplateFunctions::getPersistentVariable());
                    }

                    if ($data['is_homepage']
                        || $data['is_search_page']
                        || $data['is_edit']
                        || $data['is_browse']
                        || $data['is_login_page']
                    ) {
                        $data['show_breadcrumb'] = false;
                    }

                    if (isset($data['show_path']) && $data['show_path'] == false) {
                        $data['show_breadcrumb'] = false;
                    }

                    $uriPrefix = '/';
                    eZURI::transformURI($uriPrefix);
                    $data['uri_prefix'] = rtrim($uriPrefix, '/') . '/';


                    self::$contextData = $data;
                }

                return $operatorValue = self::$contextData;

                break;
        }

        return null;
    }

    private static function getSubSiteNodeListCache()
    {
        $cacheFilePath = eZSys::cacheDirectory() . '/subsite_node_list.cache';

        return eZClusterFileHandler::instance($cacheFilePath);
    }

    private static function getSubSiteNodeList()
    {
        return self::getSubSiteNodeListCache()->processCache(
            function ($file) {
                $content = include( $file );

                return $content;
            },
            function () {
                $list = array();
                $ini = eZINI::instance('ocoperatorscollection.ini');
                $identifiers = $ini->hasVariable('Subsite', 'Classes') ? $ini->variable('Subsite', 'Classes') : array();
                if (!empty($identifiers)) {
                    /** @var eZContentObjectTreeNode[] $nodes */
                    $nodes = eZContentObjectTreeNode::subTreeByNodeID(array(
                        'ClassFilterType' => 'include',
                        'ClassFilterArray' => $identifiers,
                        'LoadDataMap' => false,
                        'Limitation' => array()
                    ), 1);
                    foreach ($nodes as $node) {
                        $list[$node->attribute('node_id')] = $node->attribute('contentobject_id');
                    }
                }

                return array(
                    'content' => $list,
                    'scope' => 'cache',
                    'datatype' => 'php',
                    'store' => true
                );
            }
        );
    }

    public static function clearCache()
    {
        self::getSubSiteNodeListCache()->purge();
    }
}
