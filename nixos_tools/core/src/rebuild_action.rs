use std::io::{Seek, SeekFrom, Write};
use std::path::{Path, PathBuf};

use anyhow::Context;
use duct::cmd;
use tempfs::TempFile;

use crate::hardware_configuration_source::HardwareConfigurationSource;
use crate::rebuild_configuration::RebuildConfiguration;
use crate::rebuild_mode::RebuildMode;
use crate::rebuild_target::RebuildTarget;

#[derive(Debug)]
pub struct RebuildAction
{
    pub mode: RebuildMode,
    pub target: RebuildTarget,
    pub configuration: RebuildConfiguration,
    pub hardware_configuration_source: Option<HardwareConfigurationSource>,
    pub flake_path: PathBuf
}

impl RebuildAction
{
    pub fn execute(&self) -> anyhow::Result<String>
    {
        let _hardware_config =
            generate_hardware_config(&self.flake_path).with_context(|| format!("{self:?}"))?;

        let nixos_rebuild = cmd!(
            "sudo",
            "nixos-rebuild",
            "--flake",
            format!("path:.#{}", self.configuration.name),
            self.mode.to_string()
        )
        .dir(&self.flake_path)
        .read()
        .with_context(|| format!("{self:?}"))?;

        Ok(nixos_rebuild)
    }
}

fn generate_hardware_config(path: &Path) -> anyhow::Result<TempFile>
{
    let content = cmd!("nixos-generate-config", "--show-hardware-config")
        .read()
        .context("failed to generate nixos hardware config")?;

    let file_path = path.join("hardware-configuration.nix");

    let mut file = tempfs::TempFile::new_here(file_path)?;

    _ = file
        .write(content.as_bytes())
        .context("failed to create hardware-configuration.nix file at: {path:?}")?;

    file.flush()?;
    _ = file.seek(SeekFrom::Start(0))?;

    Ok(file)
}

#[cfg(test)]
pub mod tests
{
    use std::fs;
    use std::io::Read;

    use crate::rebuild_action::generate_hardware_config;

    #[test]
    pub fn create_hardware_config_file() -> anyhow::Result<()>
    {
        let temp_dir = tempfs::TempDir::new("nixos_tools/create_hardware_config_file")?;
        let expected_file = temp_dir.as_ref().join("hardware-configuration.nix");

        {
            let mut hardware_config = generate_hardware_config(temp_dir.as_ref())?;

            let mut content = String::new();
            _ = hardware_config.read_to_string(&mut content).unwrap();
            eprintln!("{content}");

            assert!(fs::exists(&expected_file)?);
        }

        assert!(!fs::exists(&expected_file)?);

        Ok(())
    }
}
