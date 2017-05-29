find_package ( Boost 1.58 )

if (NOT Boost_FOUND )
	set ( BOOST_URL "https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2")
	set ( BOOST_MD5 "93eecce2abed9d2442c9676914709349")
	set ( BOOST_ZIP_OUT ${CMAKE_CURRENT_BINARY_DIR}/boost_1_64_0.tar.bz2 )
	set ( BOOST_ROOT ${CMAKE_CURRENT_BINARY_DIR}/boost_1_64_0 )

	if ( NOT EXISTS ${BOOST_ROOT} )
		# Download zip file
		message ("Downloading ${BOOST_URL}")
		file (DOWNLOAD ${BOOST_URL} ${BOOST_ZIP_OUT}
			EXPECTED_MD5 ${BOOST_MD5}
			SHOW_PROGRESS STATUS status)
		list ( GET status 0 ret )
		list ( GET status 0 str)
		if ( NOT ret EQUAL 0)
			message (FATAL_ERROR "Download failed")
		endif()
		# Unpack zip file
		message ("Unpacking ${BOOST_ZIP_OUT}")
		execute_process(COMMAND cmake -E tar zxf ${BOOST_ZIP_OUT} WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
		# Remove zip file
		if ( EXISTS ${BOOST_ZIP_OUT} )
			file (REMOVE ${BOOST_ZIP_OUT})
		endif()
		# Try to find Boost again, this time REQUIRED
	endif()
	find_package ( Boost 1.58 REQUIRED )
endif()
