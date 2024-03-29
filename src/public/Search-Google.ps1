function Search-Google {

	<#
	.SYNOPSIS
		Google Suche verwenden
	.DESCRIPTION
		Schnell eine Google-Suche von Powershell starten
	.EXAMPLE
	   Search-Google Error code 5
	   --New google search results will open listing top entries for 'error code 5'
	.EXAMPLE
	   search-google (gwmi win32_baseboard).Product maximum ram
	   If you need to get the maximum ram for your motherboard, you can even use this
	   type of syntax
	.NOTES
		Author: Kai Krutscho
	.LINK
		https://www.github.com/kaimodo/ToModule
	.LINK
		about_comment_based_help
	#>


		# This block is used to provide optional one-time pre-processing for the function.
		Begin {
			$query = 'https://www.google.com/search?q='
		}
		Process {
			Write-Host $args.Count, "Arguments detected"
			"Parsing out Arguments: $args"
			for ($i = 0; $i -le $args.Count; $i++) {
				$args | % {"Arg $i `t $_ `t Length `t" + $_.Length, " characters"; $i++}
			}


			$args | % {$query = $query + "$_+"}
			$url = "$query"
		}
		End {
			$url.Substring(0, $url.Length - 1)
			"Final Search will be $url"
			"Invoking..."
			start "$url"
		}
	}