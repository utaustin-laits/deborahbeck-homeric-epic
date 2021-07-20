<?php

require_once 'lib/Dase/DBO.php';

/**
 * @property int speech_id
 * @property int agent_id
 * @property string role
 */
class Dase_DBO_AgentRole extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'agent_role', array('speech_id','agent_id','role'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getSpeech_id() { return $this->fields["speech_id"]; }
    public function getAgent_id() { return $this->fields["agent_id"]; }
    public function getRole() { return $this->fields["role"]; }
}