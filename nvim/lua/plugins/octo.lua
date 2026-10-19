-- Read, review, comment on and approve GitHub PRs without leaving Neovim.
--
-- Everything it needs was already here: gh (authed), plenary, telescope and
-- nvim-web-devicons. It does not need diffview -- its review panel is its own.
require("octo").setup({
  picker = "telescope",

  -- Bare `:Octo` lists the available actions instead of erroring. Worth
  -- having while the command surface is still unfamiliar.
  enable_builtin = true,

  suppress_missing_scope = {
    -- The gh token here carries `repo`, which covers everything below.
    -- Projects v2 would want `read:project` (`gh auth refresh -s read:project`),
    -- and none of the PR review flow touches it -- so skip the warning rather
    -- than widen the token for a feature that is not used.
    projects_v2 = true,
  },
})
