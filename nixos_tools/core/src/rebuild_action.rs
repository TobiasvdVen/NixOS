use std::fs;
use std::io::{Read, Seek, SeekFrom, Write};
use std::path::Path;

use anyhow::Context;
use duct::cmd;
use tempfs::TempFile;

use crate::hardware_configuration_source::HardwareConfigurationSource;
use crate::rebuild_mode::RebuildMode;
use crate::rebuild_target::RebuildTarget;

pub struct RebuildAction
{
    pub mode: RebuildMode,
    pub target: RebuildTarget,
    pub hardware_configuration_source: Option<HardwareConfigurationSource>
}

impl RebuildAction
{
    pub fn execute(&self) -> anyhow::Result<String>
    {
        Err(anyhow::format_err!("not implemented"))
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
    pub fn create_hardware_config_file()
    {
        let temp_dir = tempfs::TempDir::new("nixos_tools/create_hardware_config_file").unwrap();
        let expected_file = temp_dir.as_ref().join("hardware-configuration.nix");

        {
            let mut hardware_config = generate_hardware_config(temp_dir.as_ref()).unwrap();

            let mut content = String::new();
            _ = hardware_config.read_to_string(&mut content).unwrap();
            eprintln!("{content}");

            assert!(fs::exists(&expected_file).unwrap());
        }

        assert!(!fs::exists(&expected_file).unwrap());
    }
}
