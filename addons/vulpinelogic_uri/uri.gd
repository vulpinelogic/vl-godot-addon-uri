class_name VulpineLogicURI

extends RefCounted

var protocol: String = ""
var host: String = ""
var port: int = -1
var path: String = "/"
var query: Dictionary = {}

var url: String = "":
	set(value):
		url = value
		
		var parsed_url = _parse_url(url)
		query = parsed_url.query
		path = parsed_url.path
		host = parsed_url.hostname
		port = int(parsed_url.port)
		protocol = parsed_url.protocol


static func parse_query(query_string: String) -> Dictionary:
	return Array(query_string.split("&")).reduce(func (acc: Dictionary, entry: String):
		var pair = entry.split("=", true, 1)
		var key = pair[0].uri_decode()
		var value = pair[1].uri_decode() if pair.size() == 2 else ""
		
		if key in acc:
			if acc[key] is String:
				acc[key] = [acc[key], value]
			else:
				acc[key].push_back(value)
		else:
			acc[key] = value
			
		return acc
	, {})


func _init(from: String) -> void:
	url = from


func _parse_url(url_string: String) -> Dictionary:
	var url_parts = []
	var offset = 0
	var end = 0
	
	end = url_string.find("://", offset)
	
	var protocol_section = url_string.substr(offset, maxi(maxi(end, 0)-offset, 0))
	offset += protocol_section.length() + 3 if end > -1 else 0
	url_parts.push_back(protocol_section)
	
	end = url.find("@", offset)

	var credentials = url.substr(offset, maxi(maxi(end, 0)-offset, 0))
	var split_credentials = credentials.split(":", true, 1)
	offset += (credentials.length() + 1) if end > -1 else 0
	url_parts.push_back(split_credentials[0].uri_decode())
	
	if split_credentials.size() > 1:
		url_parts.push_back(split_credentials[1].uri_decode())
	else:
		url_parts.push_back("")

	end = url.find("/", offset)
	
	var host_section = url.substr(offset, maxi(maxi(end, 0)-offset, 0))
	var split_host = host_section.split(":", true, 1)
	offset += host_section.length() if end > -1 else 0
	url_parts.push_back(split_host[0].uri_decode())

	if split_host.size() > 1:
		url_parts.push_back(split_host[1].uri_decode())
	else:
		url_parts.push_back(-1)

	var resource_split = url.substr(offset).split("?", true, 1)	
	var path_string = resource_split[0]
	url_parts.push_back(path_string.uri_decode() if path_string.length() > 0 else "/")
	url_parts.push_back(resource_split[1] if resource_split.size() > 1 else "")
		
	return {
		"protocol": url_parts[0],
		"username": url_parts[1],
		"password": url_parts[2],
		"hostname": url_parts[3],
		"port": url_parts[4],
		"path": url_parts[5],
		"query": VulpineLogicURI.parse_query(url_parts[6])
	}
