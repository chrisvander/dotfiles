function p --wraps='pnpm prisma' --wraps='pnpm nx run db:prisma' --description 'alias p pnpm prisma'
    pnpm nx run db:prisma $argv

end
