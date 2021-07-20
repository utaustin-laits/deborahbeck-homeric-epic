<?php

require_once 'lib/Dase/DBO.php';

class Dase_DBO_Speech extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'speech', array('book_number','end_verse','end_verse_of_enclosing','length','length_of_enclosing','move_of_enclosing','narrative_level','notes','speech_act_subtype_of_enclosing','speech_act_type_of_enclosing','start_verse','start_verse_of_enclosing','subordinate_clause','type_of_speech_repr','verb_of_speaking','verse_number','work','speech_text'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getBook_number() { return $this->fields["book_number"]; }
    public function getEnd_verse() { return $this->fields["end_verse"]; }
    public function getEnd_verse_of_enclosing() { return $this->fields["end_verse_of_enclosing"]; }
    public function getLength() { return $this->fields["length"]; }
    public function getLength_of_enclosing() { return $this->fields["length_of_enclosing"]; }
    public function getMove_of_enclosing() { return $this->fields["move_of_enclosing"]; }
    public function getNarrative_level() { return $this->fields["narrative_level"]; }
    public function getNotes() { return $this->fields["notes"]; }
    public function getSpeech_act_subtype_of_enclosing() { return $this->fields["speech_act_subtype_of_enclosing"]; }
    public function getSpeech_act_type_of_enclosing() { return $this->fields["speech_act_type_of_enclosing"]; }
    public function getStart_verse() { return $this->fields["start_verse"]; }
    public function getStart_verse_of_enclosing() { return $this->fields["start_verse_of_enclosing"]; }
    public function getSubordinate_clause() { return $this->fields["subordinate_clause"]; }
    public function getType_of_speech_repr() { return $this->fields["type_of_speech_repr"]; }
    public function getVerb_of_speaking() { return $this->fields["verb_of_speaking"]; }
    public function getVerse_number() { return $this->fields["verse_number"]; }
    public function getWork() { return $this->fields["work"]; }
    public function getSpeech_text() { return $this->fields["speech_text"]; }
}