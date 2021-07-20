<?php

require_once 'lib/Dase/DBO.php';

/**
 * @property string gender
 */
class Dase_DBO_Agent extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'agent', array('name','gender'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getName() { return $this->fields["name"]; }
    public function getGender() { return $this->fields["gender"]; }
}