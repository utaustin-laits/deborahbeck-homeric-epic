<?php

class Dase_DBO_Exception extends Exception {}

class Dase_DBO implements IteratorAggregate
{
	protected $fields = array(); 
	private $table;
	protected $limit;
	protected $qualifiers = array();
	public $bind = array();
	public $pdo;
	public $id = 0;
	public $sql;

	function __construct($pdo, $table, $fields )
	{
		$this->pdo = $pdo;
		$this->table = $table;
		foreach( $fields as $key ) {
			$this->fields[ $key ] = null;
		}
	}

	public function getTable()
	{
		return $this->table;
	}

	public function __get( $key )
	{
		if ( array_key_exists( $key, $this->fields ) ) {
			return $this->fields[ $key ];
		}
		//automatically call accessor method is it exists
		$classname = get_class($this);
		$method = 'get'.ucfirst($key);
		if (method_exists($classname,$method)) {
			return $this->{$method}();
		}	
	}

	public function __set( $key, $value )
	{
		if ( array_key_exists( $key, $this->fields ) ) {
			$this->fields[ $key ] = $value;
			return true;
		}
		return false;
	}

	private function _dbGet() {
		return $this->pdo;
	}

	function setLimit($limit)
	{
		$this->limit = $limit;
	}

	function addWhere($field,$value,$operator)
	{
		if ( 
				array_key_exists( $field, $this->fields) &&
				in_array(strtolower($operator),array('is not','is','ilike','like','not ilike','not like','=','!=','<','>','<=','>='))
		   ) {
			$this->qualifiers[] = array(
					'field' => $field,
					'value' => $value,
					'operator' => $operator
					);
		} else {
			throw new Dase_DBO_Exception('addWhere problem');
		}
	}

	function __toString()
	{
		$members = '';
		$table = $this->table;
		$id = $this->id;
		foreach ($this->fields as $key => $value) {
			$members .= "$key: $value\n";
		}
		$out = "--$table ($id)--\n$members\n";
		return $out;
	}

	function load( $id )
	{
		if (!$id) {return false;}
		$this->id = $id;
		$db = $this->_dbGet();
		$table = $this->table;
		$sql = "SELECT * FROM $table WHERE id=:id";
		$sth = $db->prepare($sql);
		if (! $sth) {
			$errs = $db->errorInfo();
			if (isset($errs[2])) {
				throw new Dase_DBO_Exception($errs[2]);
			}
		}
		$sth->setFetchMode(PDO::FETCH_INTO, $this);
		$sth->execute(array( ':id' => $this->id));
		if ($sth->fetch()) {
			return $this;
		} else {
			return false;
		}
	}

	function getMethods()
	{
		$class = new ReflectionClass(get_class($this));
		return $class->getMethods();
	}

	function findOne()
	{
		$this->setLimit(1);
		$set = $this->find()->fetchAll();
		if (count($set)) {
			return $set[0];
		}
		return false;
	}

	function findAll($return_empty_array=false)
	{
		$set = array();
		$iter = $this->find();
		foreach ($iter as $it) {
			$set[$it->id] = clone($it);
		}
		if (count($set)) {
			return $set;
		} else {
			if ($return_empty_array) {
				return $set;
			}
			return false;
		}
	}

	function find()
	{
		//finds matches based on set fields (omitting 'id')
		//returns an iterator
		$dbh = $this->pdo;
		$sets = array();
		$bind = array();
		$limit = '';
		foreach( array_keys( $this->fields ) as $field ) {
			if (isset($this->fields[ $field ]) 
					&& ('id' != $field)) {
				$sets []= "$field = :$field";
				$bind[":$field"] = $this->fields[ $field ];
			}
		}
		if (isset($this->qualifiers)) {
			//work on this
			foreach ($this->qualifiers as $qual) {
				$f = $qual['field'];
				$op = $qual['operator'];
				//allows is to add 'is null' qualifier
				if ('null' == $qual['value']) {
					$v = $qual['value'];
				} else {
					if(is_numeric($qual['value'])){
						$v = $qual['value'];
					}else{
						$v = $dbh->quote($qual['value']);
					}
				}
				$sets[] = "$f $op $v";
			}
		}
		$where = join( " AND ", $sets );
		if ($where) {
			$sql = "SELECT * FROM ".$this->table. " WHERE ".$where;
		} else {
			$sql = "SELECT * FROM ".$this->table;
		}
		if (isset($this->limit)) {
			$sql .= " LIMIT $this->limit";
		}
		$sth = $this->pdo->prepare( $sql );
		if (!$sth) {
			throw new PDOException('cannot create statement handle');
		}

		$sth->setFetchMode(PDO::FETCH_INTO,$this);
		$sth->execute($bind);
		return $sth;
	}

	//implement SPL IteratorAggregate:
	//now simply use 'foreach' to iterate 
	//over object properties
	public function getIterator()
	{
		return new ArrayObject($this->fields);
	}
}
