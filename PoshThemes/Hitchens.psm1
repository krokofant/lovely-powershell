#requires -Version 2 -Modules posh-git

# Based on the Agnoster theme

function Write-Theme {

	param(
		[bool]
		$lastCommandFailed,
		[string]
		$with
	)

	function Set-Title {
		if ($args[0] -eq $null) { throw "You need to specify title" }
		$host.ui.RawUI.WindowTitle = $args[0]
	}

	function Get-FoldersToRepoRoot {
		$repoPath = Join-Path -Resolve $status.GitDir "\..\"
		$folders = @(); $current = (Get-Item .);
		while ((Join-Path $current.FullName "").Contains($repoPath)) {
			$folders += $current.Name; $current = $current.Parent
		};
		[array]::Reverse($folders)
		$folders
	}

	$lastColor = $sl.Colors.PromptBackgroundColor

	$prompt = Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.SessionInfoForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor

	#check the last command state and indicate if failed
	If ($lastCommandFailed) {
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.FailedCommandSymbol) " -ForegroundColor $sl.Colors.CommandFailedIconForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
	}

	#check for elevated prompt
	If (Test-Administrator) {
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
	}

	$user = [System.Environment]::UserName
	$computer = [System.Environment]::MachineName
	if (Test-NotDefaultUser($user)) {
		$prompt += Write-Prompt -Object "$user@$computer " -ForegroundColor $sl.Colors.SessionInfoForegroundColor -BackgroundColor $sl.Colors.SessionInfoBackgroundColor
	}

	if (Test-VirtualEnv) {
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.SessionInfoBackgroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.VirtualEnvSymbol) $(Get-VirtualEnvName) " -ForegroundColor $sl.Colors.VirtualEnvForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.VirtualEnvBackgroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
	}
	else {
		$prompt += Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) " -ForegroundColor $sl.Colors.SessionInfoBackgroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
	}

	$status = Get-VCSStatus
	if ($status) {
		[array]$folders = Get-FoldersToRepoRoot
		Set-Title $folders[0]
		$pwdIsRepoRoot = $folders.Count -eq 1
		$prompt += Write-Prompt -Object ([char]::ConvertFromUtf32(0xE0B7) + $folders[0] + [char]::ConvertFromUtf32(0xE0B5) + " ") -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
		if (!$pwdIsRepoRoot) {
			$prefix = & { if ($folders.Count -gt 2) { (".." + $sl.PromptSymbols.PathSeparator) * ($folders.Count - 1) } else { $sl.PromptSymbols.PathSeparator } }
			$prompt += Write-Prompt -Object ($prefix + " " + $folders[-1] + " ") -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
		}

		$themeInfo = Get-VcsInfo -status ($status)
		$lastColor = $themeInfo.BackgroundColor
		$prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $sl.Colors.PromptBackgroundColor -BackgroundColor $lastColor
		$prompt += Write-Prompt -Object " $($themeInfo.VcInfo) " -BackgroundColor $lastColor -ForegroundColor $sl.Colors.GitForegroundColor
	}
	else {
		# Writes the drive portion
		$prompt += Write-Prompt -Object (Get-ShortPath -dir $pwd) -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
		$prompt += Write-Prompt -Object ' ' -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
	}

	if ($with) {
		$prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $lastColor -BackgroundColor $sl.Colors.WithBackgroundColor
		$prompt += Write-Prompt -Object " $($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.WithForegroundColor
		$lastColor = $sl.Colors.WithBackgroundColor
	}

	# Writes the postfix to the prompt
	$prompt += Write-Prompt -Object $sl.PromptSymbols.SegmentForwardSymbol -ForegroundColor $lastColor
	$prompt += ' '
	$prompt
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.SegmentForwardSymbol = [char]::ConvertFromUtf32(0xE0B0)
$sl.PromptSymbols.PathSeparator = '/'
$sl.Colors.PromptForegroundColor = [ConsoleColor]::Black
$sl.Colors.PromptSymbolColor = [ConsoleColor]::Black
$sl.Colors.PromptHighlightColor = [ConsoleColor]::DarkBlue
$sl.Colors.GitForegroundColor = [ConsoleColor]::Black
$sl.Colors.WithForegroundColor = [ConsoleColor]::White
$sl.Colors.WithBackgroundColor = [ConsoleColor]::DarkRed
$sl.Colors.VirtualEnvBackgroundColor = [System.ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor = [System.ConsoleColor]::White
